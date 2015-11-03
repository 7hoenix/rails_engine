class Transaction < ActiveRecord::Base
  belongs_to :invoice

  scope :random, -> { find((1..Transaction.count).to_a.sample) }
end
