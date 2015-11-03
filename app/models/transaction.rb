class Transaction < ActiveRecord::Base
  has_many :invoices

  scope :random, -> { find((1..Transaction.count).to_a.sample) }
end
