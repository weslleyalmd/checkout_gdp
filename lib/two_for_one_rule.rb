class TwoForOneRule
  def initialize(applicable_client, code, eligible_qtty)
    @applicable_client = applicable_client
    @code              = code
    @eligible_qtty     = eligible_qtty
  end

  def apply(items, client)
    if @applicable_client == client
      selected_items = items.select{ |i| i.code == @code}
      if selected_items.size >= @eligible_qtty.to_i
        selected_items.each_slice(@eligible_qtty.to_i) do |item, item_free|
          item_free.price = 0 unless item_free.nil?
        end
      end
    end
  end
end
