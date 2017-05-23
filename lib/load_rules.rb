class LoadRule

  def initialize(rules_file)
    @rules_json = JSON.parse(rules_file)
  end

  def load
    rules = []

    @rules_json.each do |rule|
      if rule['type'] == "twoforone"
        rules << TwoForOneRule.new(rule['client'], rule['product'], rule['eligible_qtty'].to_i)
      elsif rule['type'] == "discount"
        rules << DiscountRule.new(rule['client'], rule['product'], rule['eligible_qtty'].to_i, rule['new_price'].to_f)
      end
    end

    return rules
  end
end