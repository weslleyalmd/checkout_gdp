require 'test/unit'
require_relative '../lib/discount_rule.rb'
require_relative '../lib/checkout.rb'

class DiscountRuleTest < Test::Unit::TestCase
  def setup
    @new_price = 299.99
    @rule = DiscountRule.new('APPLE', 'standout', 3, @new_price)
    @checkout = Checkout.new([@rule])
    @store = @checkout.store
    @classic = @store.find('classic')
    @standout = @store.find('standout')
    @premium = @store.find('premium')

    @classic_one = Item.new(@classic.code, @classic.price)
    @standout_ad_one = Item.new(@standout.code, @standout.price)
    @standout_ad_two = Item.new(@standout.code, @standout.price)
    @standout_ad_three = Item.new(@standout.code, @standout.price)


    @default_client = "default_client"
    @premium_client = "APPLE"

  end

  def test_rule_application_without_items_to_apply_discount
    items = [ @classic_one, @standout_ad_one ]
    @rule.apply(items, @default_client)
    assert_equal @classic_one.price, @classic.price, "Item price didn't change"
    assert_equal @standout_ad_one.price, @standout.price, "Item price didn't change"
  end

  def test_rule_application_with_enough_quantity_to_apply_discount_but_premium_client
    items = [ @standout_ad_one, @standout_ad_two, @standout_ad_three ]
    @rule.apply(items, @premium_client)
    assert_equal @standout_ad_one.price, @new_price, "Item price changed"
    assert_equal @standout_ad_two.price, @new_price, "Item price changed"
    assert_equal @standout_ad_three.price, @new_price, "Item price changed"
  end

  def test_rule_application_with_enough_quantity_to_apply_discount_but_default_client
    items = [ @standout_ad_one, @standout_ad_two, @standout_ad_three ]
    @rule.apply(items, @default_client)
    assert_equal @standout_ad_one.price, @standout.price, "Item price didn't change"
    assert_equal @standout_ad_two.price, @standout.price, "Item price didn't change"
    assert_equal @standout_ad_three.price, @standout.price, "Item price didn't change"
  end

end