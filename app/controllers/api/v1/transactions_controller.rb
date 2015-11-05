class Api::V1::TransactionsController < ApplicationController
  respond_to :json

  def index
    respond_with Transaction.all
  end

  def show
    respond_with find_transaction
  end

  def find
    respond_with Transaction.find_by(find_params)
  end

  def find_all
    respond_with Transaction.where(find_params)
  end

  def random
    respond_with Transaction.random
  end

  def invoice
    respond_with find_transaction.invoice
  end

  private

  def find_params
    params.permit(:invoice_id, :credit_card_number,
      :credit_card_expiration_date, :result, :id, :updated_at, :created_at)
  end

  def find_transaction
    Transaction.find_by(id: params[:id])
  end
end
