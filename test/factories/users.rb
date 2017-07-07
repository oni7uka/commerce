FactoryGirl.define do
  factory :user do
    name Faker::Name.name
    password Faker::Number.number(6)
    avatar Faker::Avatar.image
  end
end
