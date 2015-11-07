require 'rails_helper'

RSpec.describe Api::V1::Merchants::ItemsController, type: :controller do
  include Controllers::JsonHelpers
  describe "GET #index" do
    it "returns associated items for this merchant" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)
      create(:item, merchant_id: merchant.id)

      get :index, merchant_id: merchant.id, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.first["name"]).to eq(item.name)
    end
  end
end
