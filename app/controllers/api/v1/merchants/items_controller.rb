class Api::V1::Merchants::ItemsController < Api::V1::ItemsController
  def index
    respond_with Item.where(merchant_id: params[:merchant_id])
  end
end
