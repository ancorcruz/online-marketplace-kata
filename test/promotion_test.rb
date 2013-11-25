require 'test/unit'
require File.expand_path('../../promotion', __FILE__)

class PromotionTest < Test::Unit::TestCase
  def test_get_discount_for
    promo = Promotion.new { |subtotal| subtotal / 10 if subtotal >= 6000 }

    assert_equal 0,   promo.get_discount_for(5999)
    assert_equal 600, promo.get_discount_for(6000)
    assert_equal 750, promo.get_discount_for(7500)
  end
end
