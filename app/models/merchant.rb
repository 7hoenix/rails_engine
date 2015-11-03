class Merchant < ActiveRecord::Base
  has_many :invoices
  has_many :items

  scope :random, -> { order("RANDOM()").first }

  def self.revenue
  end
end
