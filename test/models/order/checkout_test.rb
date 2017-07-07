require 'test_helper'

class CheckoutTest < ActiveSupport::TestCase
  let(:order){ create(:order) }
  let(:order_with_line_items) { create(:order_with_line_items, line_items_count: 4) }
  let(:payment_state_order) {create(:payment_state_order)}

  test "init state" do
    assert_equal "cart", order.state
    assert_not order.number.blank?
  end

  test "could not next if line_items empty" do
    assert_raises Order::Error::Cart do
      order.next
    end
  end

  test "should change cart to payment " do
    create(:wechat_payment)
    order_with_line_items.next
    assert_equal "payment", order_with_line_items.state
  end

  test "should fail if not exist payment method" do
    assert_raises Order::Error::Payment do
      order_with_line_items.next
    end
  end
end
