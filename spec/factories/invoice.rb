FactoryGirl.define do
  factory :invoice do
    status "active"
    customer
    merchant
  end
end
