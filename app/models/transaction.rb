class Transaction < ActiveRecord::Base
  has_many :invoices
end
