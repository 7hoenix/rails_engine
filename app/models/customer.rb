class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices

  scope :random, -> { order("RANDOM()").first }
end
