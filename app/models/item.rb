class Item < ActiveRecord::Base
  before_create :correct_unit_price

  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  scope :random, -> { order("RANDOM()").first }

  def correct_unit_price
    self.unit_price = unit_price / 100.00
  end

  def self.most_revenue(quantity)
    Item.select("items.*, sum(invoice_items.quantity * invoice_items.unit_price)
      AS revenue_generated")
      .joins(:invoice_items)
      .group("items.id")
      .order("revenue_generated DESC")
      .limit(quantity)
      .merge(InvoiceItem.successful)
  end

  def self.most_items(quantity)
    Item.select("items.*, sum(invoice_items.quantity) AS item_count")
      .joins(:invoice_items)
      .group("items.id")
      .order("item_count DESC")
      .limit(quantity)
      .merge(InvoiceItem.successful)
  end

  def self.best_day(id)
    InvoiceItem.successful
      .where("item_id" => id)
      .group("invoices.created_at")
      .order("sum_quantity DESC")
      .sum("quantity").first[0]
  end
end
