FactoryGirl.define do
  factory :payment do
    association :order
    association :payment_method, factory: :wechat_payment
  end
end
