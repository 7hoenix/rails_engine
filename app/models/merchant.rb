class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  scope :random, -> { find((1..Merchant.count).to_a.sample) }
end
