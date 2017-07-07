FactoryGirl.define do
  factory :address do
    mobile Faker::PhoneNumber.cell_phone
    receiver Faker::Name.name
    zip_code Faker::Address.zip_code
  end
end
