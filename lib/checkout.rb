require_relative 'store'
require_relative 'item'

class Checkout
  attr_reader :total, :store, :items

  def initialize(pricing_rules)
    @rules   = pricing_rules
    classic  = Product.new('classic', 'Classic AD', 269.99)
    standout = Product.new('standout', 'Standout AD', 322.99)
    premium  = Product.new('premium', 'premium AD', 394.99)
    @store   = Store.new(classic, standout, premium)
    @items   = []
    @valid_codes = @store.valid_codes
  end

  def scan(code)
    if @valid_codes.include?(code)
      product = @store.find(code)
      item = Item.new(product.code, product.price)
      @items.push(item)
      true
    else
      false
    end
  end

  def show(client)
    items = @items.map(&:code).join(', ')
    puts items.size > 0 ? "Items: #{items}" : 'No items to checkout'
    puts "Total: $#{self.total(client)}"
    @items   = []
  end

  def total(client)
    @rules.each{ |rule| rule.apply(@items, client) }
    @items.inject(0.0){ |total, item| total += item.price}
  end
end
