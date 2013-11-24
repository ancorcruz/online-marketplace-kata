require 'test/unit'
require File.expand_path('../../product', __FILE__)

class ProductTest < Test::Unit::TestCase
  def test_product_creation
    product = Product.new "003", "Kids T-shirt", 19.95
    assert_equal "003",          product.code
    assert_equal "Kids T-shirt", product.name
    assert_equal 19.95,          product.price
    assert_equal 1995,           product.price_cents
  end
end
