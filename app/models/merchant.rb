class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

  scope :random, -> { order("RANDOM()").first }

  def revenue(params = nil)
    if params[:date]
      Merchant.revenue_by_date(params)
    else
      revenue_for_merchant
    end
  end

  def revenue_for_merchant
    InvoiceItem.joins(:merchants, :transactions)
      .where("merchants.id" => self.id)
      .merge(Transaction.successful)
      .sum("quantity * unit_price")
  end

  def self.revenue_by_date(params)
    InvoiceItem.joins(:merchants, :transactions, :invoice)
      .where("merchants.id" => params[:id])
      .merge(Transaction.successful)
      .merge(Invoice.created_on(params[:date]))
      .sum("quantity * unit_price")
  end

  def self.favorite_customer(params)
    Customer.select("customers.*, count(transactions.id) AS transactions_count")
      .joins(:merchants, :transactions)
      .where("merchants.id" => params[:id])
      .merge(Transaction.successful)
      .group("customers.id")
      .order("transactions_count DESC")
      .limit(1)
  end

  def self.customers_with_pending_invoices(params)
    Customer.select("customers.*, count(transactions.id) AS transactions_count")
      .joins(:merchants, :invoices)
      .where("merchants.id" => params[:id])
      .merge(Invoice.failed)
      .group("customers.id")
      .order("transactions_count DESC")
  end

  def self.most_revenue(quantity)
    select("merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) AS merchant_revenue")
      .joins(:invoice_items)
      .group("merchants.id")
      .order("merchant_revenue DESC")
      .limit(quantity)
      .merge(InvoiceItem.successful)
  end

  def self.most_items(quantity)
    select("merchants.*, sum(invoice_items.quantity) AS item_quantity")
      .joins(:invoice_items)
      .group("merchants.id")
      .order("item_quantity DESC")
      .limit(quantity)
      .merge(InvoiceItem.successful)
  end

  def self.revenue(date)
    InvoiceItem.joins(:invoice)
      .where("invoices.created_at" => date)
      .merge(InvoiceItem.successful)
      .sum("quantity * unit_price")
  end
end
