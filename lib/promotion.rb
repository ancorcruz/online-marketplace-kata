class Promotion
  def initialize &rule
    @rule = rule
  end

  def get_discount_for *args
    @rule.call(*args) || 0
  end
end
