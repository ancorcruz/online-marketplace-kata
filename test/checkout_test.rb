require 'test/unit'
require File.expand_path('../../checkout', __FILE__)

class CheckoutTest < Test::Unit::TestCase
  def setup
    @p1 = Product.new "001", "Travel Card Holder", 9.25
    @p2 = Product.new "002", "Personalised cufflinks", 45.00
    @p3 = Product.new "003", "Kids T-shirt", 19.95
  end

  def total_price_for(items = [])
    promotional_rules = nil
    co = Checkout.new(promotional_rules)
    items.each { |item| co.scan item }
    co.total
  end

  def test_total_without_promotions
    assert_equal 0,     total_price_for([])
    assert_equal 74.20, total_price_for([@p1, @p2, @p3])
    assert_equal 38.45, total_price_for([@p1, @p3, @p1])
    assert_equal 83.45, total_price_for([@p1, @p2, @p1, @p3])
  end

  def test_total_with_promotions
    assert_equal 0,     total_price_for([])
    assert_equal 66.78, total_price_for([@p1, @p2, @p3])
    assert_equal 36.95, total_price_for([@p1, @p3, @p1])
    assert_equal 73.76, total_price_for([@p1, @p2, @p1, @p3])
  end
end
