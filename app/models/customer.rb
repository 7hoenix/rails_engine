class Customer < ActiveRecord::Base
  has_many :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  scope :random, -> { order("RANDOM()").first }

  def self.favorite_merchant(params)
    Merchant.select("merchants.*, count(transactions.id) AS transactions_count")
      .joins(:customers, :transactions)
      .where("customers.id" => params[:id])
      .merge(Transaction.successful)
      .group("merchants.id")
      .order("transactions_count DESC")
      .limit(1)
  end
end
