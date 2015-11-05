class Api::V1::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    respond_with InvoiceItem.all
  end

  def show
    respond_with find_invoice_item
  end

  def find
    respond_with InvoiceItem.find_by(find_params)
  end

  def find_all
    respond_with InvoiceItem.where(find_params)
  end

  def random
    respond_with InvoiceItem.random
  end

  def invoice
    respond_with find_invoice_item.invoice
  end

  def item
    respond_with find_invoice_item.item
  end

  private

  def find_params
    params.permit(:item_id, :invoice_id, :id, :quantity, :unit_price,
      :created_at, :updated_at)
  end

  def find_invoice_item
    InvoiceItem.find_by(id: params[:id])
  end
end
