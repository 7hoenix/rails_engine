class Api::V1::ItemsController < ApplicationController
  respond_to :json

  def index
    respond_with Item.all
  end

  def show
    respond_with find_item
  end

  def find
    respond_with Item.find_by(find_params)
  end

  def find_all
    respond_with Item.where(find_params)
  end

  def random
    respond_with Item.random
  end

  def invoice_items
    respond_with find_item.invoice_items
  end

  def merchant
    respond_with find_item.merchant
  end

  def most_revenue
    respond_with Item.most_revenue(params[:quantity])
  end

  def most_items
    respond_with Item.most_items(params[:quantity])
  end

  def best_day
    respond_with best_day: Item.best_day(params[:id])
  end

  private

  def find_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id,
      :updated_at, :created_at, :quantity)
  end

  def find_item
    Item.find_by(id: params[:id])
  end
end
