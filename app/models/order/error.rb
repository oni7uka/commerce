class Order
  class Error < StandardError
    class Cart < Order::Error;end
    class Payment < Order::Error;end
    class Address < Order::Error;end
  end
end
