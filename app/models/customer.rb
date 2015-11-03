class Customer < ActiveRecord::Base
  has_many :invoices

  scope :random, -> { find((1..Customer.count).to_a.sample) }
end
