FactoryGirl.define do
  factory :wechat_payment, class: ::PaymentMethod::WechatPayment do
    name 'Wechat'
  end
end
