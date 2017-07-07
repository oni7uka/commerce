FactoryGirl.define do
  factory :variant do
    association :product
    price Faker::Number.decimal(2)
    sku Faker::Number.number(5)
  end
end
