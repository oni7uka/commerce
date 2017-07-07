require 'faker'
FactoryGirl.define do
  factory :product do
    name Faker::Commerce.product_name
    association :category
  end
end
