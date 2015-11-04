class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :invoice
  has_many :transactions, through: :invoice

  scope :random, -> { order("RANDOM()").first }
  scope :created_on, ->(date) { joins(:invoices).where(invoices: { created_at: date }) }
end
