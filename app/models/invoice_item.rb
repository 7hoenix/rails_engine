class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :item

  scope :random, -> { order("RANDOM()").first }
  scope :revenue, -> { quantity * unit_price }
end
