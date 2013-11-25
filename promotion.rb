class Promotion
  def initialize &rule
    @rule = rule
  end

  def get_discount_for checkout
    @rule.call(checkout) || 0
  end
end
