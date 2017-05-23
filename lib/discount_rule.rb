class DiscountRule
  attr_accessor :new_price

  def initialize(applicable_client, code, eligible_qtty, new_price)
    @applicable_client = applicable_client
    @code = code
    @eligible_qtty = eligible_qtty
    @new_price = new_price
  end

  def apply(items, client)
    if @applicable_client == client
      selected_items = items.select{ |i| i.code == @code}
      selected_items.each{ |item| item.price = @new_price } if selected_items.size >= @eligible_qtty
    end
  end
end