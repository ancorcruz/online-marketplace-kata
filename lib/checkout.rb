require File.expand_path('../product', __FILE__)
require File.expand_path('../promotion', __FILE__)

class Checkout
  def initialize(promotional_rules)
    @promotional_rules = promotional_rules || []
    @items = []
  end

  def scan item
    @items << item
  end

  def item_amount product_code
    @items.count { |item| item.code == product_code }
  end

  def subtotal
    @items.map(&:price_cents).reduce(:+) || 0
  end

  def total
    total = @promotional_rules.inject(subtotal) { |total, rule|
      total -= rule.get_discount_for(self, total)
    }

    total / 100.0
  end
end
