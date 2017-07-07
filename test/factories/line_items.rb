FactoryGirl.define do
  factory :line_item do
    association :variant
    association :order
    quantity Faker::Number.between(1, 10)
    after(:create) do |line_item, evaluator|
      line_item.update price: line_item.variant.price
    end
  end
end
