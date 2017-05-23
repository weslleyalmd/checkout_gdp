require 'test/unit'
require_relative '../lib/two_for_one_rule.rb'
require_relative '../lib/checkout.rb'

class TwoForOneRuleTest < Test::Unit::TestCase
  def setup
    @rule = TwoForOneRule.new('UNILEVER', 'classic', 3)
    @checkout = Checkout.new([@rule])
    @store = @checkout.store
    @classic = @store.find('classic')
    @standout = @store.find('standout')
    @premium = @store.find('premium')

    @classic_ad_one = Item.new(@classic.code, @classic.price)
    @classic_ad_two = Item.new(@classic.code, @classic.price)
    @classic_ad_three = Item.new(@classic.code, @classic.price)

    @standout_ad_one = Item.new(@standout.code, @standout.price)

    @premium_ad_one = Item.new(@premium.code, @premium.price)

    @default_client = "default_client"
    @premium_client = "UNILEVER"
  end

  def test_rule_application_without_items_to_apply_discount_default_client
    items = [ @classic_ad_one, @standout_ad_one, @premium_ad_one]
    @rule.apply(items, @premium_client)
    assert_equal @classic_ad_one.price, @classic.price, "Item price didn't change"
    assert_equal @standout_ad_one.price, @standout.price, "Item price didn't change"
  end

  def test_rule_application_without_items_to_apply_discount_premium_client
    items = [ @classic_ad_one, @standout_ad_one, @premium_ad_one ]
    @rule.apply(items, @premium_client)
    assert_equal @classic_ad_one.price, @classic.price, "Item price didn't change"
    assert_equal @standout_ad_one.price, @standout.price, "Item price didn't change"
  end

  def test_rule_application_with_items_to_apply_discount_for_premium_client
    items = [ @classic_ad_one, @classic_ad_two, @classic_ad_three, @premium_ad_one]
    @rule.apply(items, @premium_client)
    assert_equal @classic_ad_one.price, @classic.price, "Item price didn't change"
    assert_equal @classic_ad_two.price, 0, "Item price now is zero"
    assert_equal @classic_ad_three.price, @classic.price, "Item price didn't change"
    assert_equal @premium_ad_one.price, @premium.price, "Item price didn't change"
  end

  def test_rule_application_with_items_to_apply_discount_for_default_client
    items = [ @classic_ad_one, @classic_ad_two, @classic_ad_three, @premium_ad_one]
    @rule.apply(items, @default_client)
    assert_equal @classic_ad_one.price, @classic.price, "Item price didn't change"
    assert_equal @classic_ad_two.price, @classic.price, "Item price didn't change"
    assert_equal @classic_ad_three.price, @classic.price, "Item price didn't change"
    assert_equal @premium_ad_one.price, @premium.price, "Item price didn't change"
  end

end
