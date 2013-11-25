require './product'

class Checkout
  def initialize promotional_rules
    @promotional_rules = promotional_rules
    @items = []
  end

  def scan item
    @items << item
  end

  def total
    @items.inject(0) { |total, item| total += item.price_cents } / 100.0
  end
end
