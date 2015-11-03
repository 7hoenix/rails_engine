FactoryGirl.define do
  factory :item do
    name Faker::Commerce.product_name
    description Faker::Company.bs
    unit_price Faker::Number.between(10, 1000)
    merchant
  end
end
