require 'test/unit'
require_relative '../lib/store.rb'

class StoreTest < Test::Unit::TestCase

  def setup
    classic  = Product.new('classic', 'Classic AD', 269.99)
    standout = Product.new('standout', 'Standout AD', 322.99)
    premium  = Product.new('premium', 'premium AD', 394.99)
    @store   = Store.new(classic, standout, premium)
  end

  def test_that_quantity_of_products_is_correct
    assert_equal 3, @store.products_quantity, 'The store has 3 products'
  end

  def test_find_product_method
    product = @store.products.first
    assert_equal [ product.code, product.name, product.price], @store.find(product.code).to_a
    assert_equal nil, @store.find('Car')
  end

  def test_store_creates_a_new_product
    @store.add_product("SHIRT", "Awesome Shirt", 45)
    product = @store.find("SHIRT")
    assert_equal 4, @store.products_quantity, 'The store has 4 products'
    assert_equal [ product.code, product.name, product.price], @store.find(product.code).to_a
  end

  def test_valid_codes_method
    codes = []
    valid_codes = @store.valid_codes
    @store.products.each{ |product| codes.push(product.code) }
    assert_equal codes, valid_codes
  end
end