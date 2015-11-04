class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with Merchant.find_by(id: params[:id])
  end

  def find
    respond_with Merchant.find_by(find_params)
  end

  def find_all
    respond_with Merchant.where(find_params)
  end

  def random
    respond_with Merchant.random
  end

  def items
    respond_with Merchant.find(params[:id]).items
  end

  def invoices
    respond_with Merchant.find(params[:id]).invoices
  end

  def revenue
    respond_with Merchant.find(params[:id]).revenue(params)
  end

  def favorite_customer
    respond_with Merchant.favorite_customer(params).first
  end

  private

  def find_params
    params.permit(:name, :id, :created_at, :updated_at, :date)
  end
end
