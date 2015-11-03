class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice
  belongs_to :item

  scope :random, -> { find((1..InvoiceItem.count).to_a.sample) }
end
