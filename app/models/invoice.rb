class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  scope :random, -> { order("RANDOM()").first }
  scope :successful, -> { joins(:transactions).where(transactions: { result: "success" }) }
  scope :created_on, ->(date) { where(invoices: { created_at: date }) }
end
