class Product
  attr_reader :code, :name, :price_cents

  def initialize code, name, price
    @code        = code
    @name        = name
    @price_cents = (price * 100).round
  end

  def price
    @price_cents / 100.0
  end
end
