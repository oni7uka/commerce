require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  let(:order){ create(:order) }
  let(:variant) { create(:variant) }
  let(:order_with_line_items) { create(:order_with_line_items, line_items_count: 4) }

  test "should get shopping cart" do
    user = create(:user)
    assert_equal "cart", user.orders.cart.state
  end

  test "could put products to cart" do
    order.add(variant, 3)
    assert_equal 3, order.item_count
    assert_not_equal 0, order.total
    assert_equal order.total, order.item_total
    assert_equal variant.price * 3, order.total
    order.add(variant, 2)
    assert_equal 5, order.item_count
  end

  test "could update the cart" do
    line_items_attributes = order_with_line_items.line_items.pluck(:id).map do | id |
      {id: id, quantity: 1}
    end
    order_with_line_items.update_cart line_items_attributes: line_items_attributes
    assert_equal 4, order_with_line_items.item_count
  end

  test "could delete line_item form cart" do
    line_items_attributes = order_with_line_items.line_items.pluck(:id).map do | id |
      {id: id, quantity: 0}
    end
    order_with_line_items.update_cart line_items_attributes: line_items_attributes
    assert_equal 0, order_with_line_items.line_items.count
    assert_equal 0, order_with_line_items.item_count
  end

  test "could remove line item form cart" do
    id = order_with_line_items.line_items.pluck(:id).first
    order_with_line_items.remove id
    assert_equal 3, order_with_line_items.line_items.count
  end

  test "could not update line_items if it not in the cart" do
    assert_no_difference('order_with_line_items.item_count') do
      order_with_line_items.update_cart line_items_attributes:[ {id: Faker::Number.number(10), quantity: 5} ]
    end
    assert_equal 4, order_with_line_items.line_items.count
  end

  test "could empty the cart" do
    order_with_line_items.empty!
    assert_equal 0, order_with_line_items.item_count
    assert_equal 0, order_with_line_items.item_total
    assert_equal 0, order_with_line_items.total
  end
end
