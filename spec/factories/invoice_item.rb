FactoryGirl.define do
  factory :invoice_item do
    unit_price { Faker::Number.between(10, 1000) }
    quantity { Faker::Number.number(5) }
    item
    invoice
  end
end
