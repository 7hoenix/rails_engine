class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :invoice_id, :credit_card_number, :result, :updated_at,
    :created_at
end
