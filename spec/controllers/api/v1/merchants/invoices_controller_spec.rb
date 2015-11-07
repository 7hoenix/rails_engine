require 'rails_helper'

RSpec.describe Api::V1::Merchants::InvoicesController, type: :controller do
  include Controllers::JsonHelpers
  describe "GET #index" do
    it "returns associated invoices for this merchant" do
      merchant = create(:merchant)
      invoice = create(:invoice, merchant_id: merchant.id)
      create(:invoice, merchant_id: merchant.id)

      get :index, merchant_id: merchant.id, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.first["customer_id"]).to eq(invoice.customer_id)
    end
  end
end
