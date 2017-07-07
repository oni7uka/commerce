require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  let(:address) {create(:address)}

  test "could clone itself" do
    c = address.clone
    assert_nil c.id
    assert_equal address.receiver, c.receiver
    assert_equal address.mobile, c.mobile
    assert_equal address.zip_code, c.zip_code
  end
  # test "the truth" do
  #   assert true
  # end
end
