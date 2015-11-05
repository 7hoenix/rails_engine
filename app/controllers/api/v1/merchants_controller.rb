class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    respond_with Merchant.all
  end

  def show
    respond_with find_merchant
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
    respond_with find_merchant.items
  end

  def invoices
    respond_with find_merchant.invoices
  end

  def revenue
    respond_with revenue: find_merchant.revenue(params)
  end

  def favorite_customer
    respond_with Merchant.favorite_customer(params).first
  end

  def customers_with_pending_invoices
    respond_with Merchant.customers_with_pending_invoices(params)
  end

  def most_revenue
    respond_with Merchant.most_revenue(params[:quantity])
  end

  def most_items
    respond_with Merchant.most_items(params[:quantity])
  end

  def total_revenue
    respond_with total_revenue: Merchant.revenue(params[:date])
  end

  private

  def find_params
    params.permit(:name, :id, :created_at, :updated_at, :date, :quantity)
  end

  def find_merchant
    Merchant.find_by(id: params[:id])
  end
end
