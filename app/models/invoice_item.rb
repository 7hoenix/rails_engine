class InvoiceItem < ActiveRecord::Base
  before_create :correct_unit_price

  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :invoice
  has_many :transactions, through: :invoice

  scope :random, -> { order("RANDOM()").first }
  scope :created_on, ->(date) { joins(:invoices).where(invoices: { created_at: date }) }
  scope :successful, -> { joins(:transactions).where("transactions.result" => "success") }

  def correct_unit_price
    self.unit_price = unit_price / 100.00
  end
end
