require './product'
require './promotion'

class Checkout
  def initialize(promotional_rules)
    @promotional_rules = promotional_rules || []
    @items = []
  end

  def scan item
    @items << item
  end

  def subtotal
    @items.map(&:price_cents).reduce(:+) || 0
  end

  def total
    total = @promotional_rules.inject(subtotal) { |total, rule|
      total -= rule.get_discount_for(self)
    }

    total / 100.0
  end
end
