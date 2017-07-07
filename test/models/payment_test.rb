require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  let(:payment){create(:payment)}

  test "init state" do
    assert_equal 'waiting', payment.state
    assert_not payment.number.blank?
  end
  # test "the truth" do
  #   assert true
  # end
end
