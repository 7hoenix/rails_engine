class Transaction < ActiveRecord::Base
  belongs_to :invoice

  scope :random, -> { order("RANDOM()").first }
  scope :successful, -> { where result: "success" }
  scope :failed, -> { where result: "failed" }
end
