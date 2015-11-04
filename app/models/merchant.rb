class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  scope :random, -> { order("RANDOM()").first }
  scope :revenue, ->(params) { InvoiceItem.joins(:merchants)
                                          .where("merchants.id" => params[:id])
                                          .joins(:transactions)
                                          .merge(Transaction.successful)
                                          .sum("quantity * unit_price") / 100.00
  }
  scope :revenue_by_date, ->(params) { InvoiceItem.joins(:merchants)
                          .where("merchants.id" => params[:id])
                          .joins(:transactions)
                          .merge(Transaction.successful)
                          .joins(:invoice)
                          .merge(Invoice.created_on(params[:date]))
                          .sum("quantity * unit_price") / 100.00
  }
  scope :favorite_customer, ->(params) { Customer.select("customers.*, count(transactions.id) AS transactions_count")
                      .joins(:merchants)
                      .where("merchants.id" => params[:id])
                      .joins(:transactions)
                      .merge(Transaction.successful)
                      .group("customers.id")
                      .order("transactions_count DESC")
                      .limit(1)
  }

  def revenue(params)
    if params[:date]
      respond_with Merchant.revenue_by_date(params)
    else
      respond_with Merchant.revenue(params)
    end
  end
end
