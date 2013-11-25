require 'test/unit'
require File.expand_path('../../lib/checkout', __FILE__)

class CheckoutTest < Test::Unit::TestCase
  def setup
    @p1 = Product.new "001", "Travel Card Holder", 9.25
    @p2 = Product.new "002", "Personalised cufflinks", 45.00
    @p3 = Product.new "003", "Kids T-shirt", 19.95
  end

  def total_price_for(items = [])
    co = Checkout.new(@promotional_rules)
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
    @promotional_rules = [
      Promotion.new do |co|
        amount = co.item_amount('001')
        amount >= 2 ? amount * 75 : 0
      end,

      Promotion.new { |co, subtotal| subtotal / 10 if subtotal >= 6000 },
    ]

    assert_equal 0,     total_price_for([])
    assert_equal 66.78, total_price_for([@p1, @p2, @p3])
    assert_equal 36.95, total_price_for([@p1, @p3, @p1])
    assert_equal 73.76, total_price_for([@p1, @p2, @p1, @p3])
  end

  def test_item_amount
    co = Checkout.new []
    [@p1, @p2, @p3, @p2].each { |item| co.scan item }

    assert_equal 2, co.item_amount(@p2.code)
  end
end
