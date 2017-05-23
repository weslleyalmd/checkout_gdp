require 'test/unit'
require_relative '../lib/checkout.rb'
require_relative '../lib/discount_rule.rb'
require_relative '../lib/two_for_one_rule.rb'
require_relative '../lib/load_rules.rb'
require 'json'

class CheckoutTest < Test::Unit::TestCase

  def setup
    rules_file = File.read('test/resource/test_rules.json')

    load_rules = LoadRule.new(rules_file)
    @rules = load_rules.load

    @checkout = Checkout.new(@rules)
    @store = @checkout.store
  end

  def test_that_total_works_correcty_without_apply_promotions_and_invalid_codes
    @checkout.scan('classic')
    @checkout.scan('standout')
    @checkout.scan('premium')
    @checkout.scan('master')
    assert_equal 987.97, @checkout.total('default_client')
  end

  def test_checkout_example_one
    @checkout.scan('classic')
    @checkout.scan('classic')
    @checkout.scan('classic')
    @checkout.scan('premium')
    assert_equal 934.97, @checkout.total('UNILEVER')
  end

  def test_checkout_example_two
    @checkout.scan('standout')
    @checkout.scan('standout')
    @checkout.scan('standout')
    @checkout.scan('premium')
    assert_equal 1294.96, @checkout.total('APPLE')
  end

  def test_checkout_example_three
    @checkout.scan('premium')
    @checkout.scan('premium')
    @checkout.scan('premium')
    @checkout.scan('premium')
    assert_equal 1519.96, @checkout.total('NIKE')
  end

  def test_checkout_example_four
    @checkout.scan('classic')
    @checkout.scan('classic')
    @checkout.scan('classic')
    @checkout.scan('standout')
    @checkout.scan('standout')
    @checkout.scan('standout')
    @checkout.scan('premium')
    @checkout.scan('premium')
    @checkout.scan('premium')
    assert_equal 2909.91, @checkout.total('FORD')
  end

  def test_when_checkout_scan_a_new_product
    assert_equal @checkout.scan("classic"), true
    assert_equal @checkout.scan("master"), false
    assert_equal @checkout.scan("standout"), true
    assert_equal @checkout.scan("premium"), true
    assert_equal @checkout.scan("ad"), false
  end

end
