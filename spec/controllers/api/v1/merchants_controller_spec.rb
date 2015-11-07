require 'rails_helper'

RSpec.describe Api::V1::MerchantsController, type: :controller do
  include Controllers::JsonHelpers
  describe "GET #index" do
    it "returns all instances of merchant" do
      create(:merchant)
      create(:merchant)

      get :index, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.count).to eq(Merchant.count)
    end
  end

  describe "GET #show" do
    context "with a valid merchant id" do
      it "returns the associated instance of merchant" do
        merchant = create(:merchant)

        get :show, id: merchant.id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["name"]).to eq(merchant.name)
      end
    end

    context "with invalid merchant id" do
      it "doesnt return a merchant" do
        merchant = create(:merchant)

        get :show, id: merchant.id + 1, format: :json

        expect(response.body).to eq("null")
      end
    end
  end

  describe "GET #find" do
    context "with valid params" do
      it "returns the associated instance of merchant with id" do
        merchant = create(:merchant)

        get :find, id: merchant.id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["name"]).to eq(merchant.name)
      end

      it "returns the associated instance of merchant with first name" do
        merchant = create(:merchant)

        get :find, name: merchant.name, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["name"]).to eq(merchant.name)
      end
    end
  end

  describe "GET #find_all" do
    # before(:each) do
      # @merchant1 = create(:merchant, : "Justin", last_name: "Jones")
      # create(:merchant, first_name: "Justin", last_name: "Holzmann")
      # create(:merchant, last_name: "Jones")
    # end

    # context "with valid params" do
      # it "returns associated instances of merchant with same first name" do
        # get :find_all, first_name: @merchant1.first_name, format: :json

        # expect(response).to have_http_status(:ok)
        # expect(json.count).to eq(2)
        # expect(json.last["first_name"]).to eq(@merchant1.first_name)
      # end

      # it "returns the associated instances of merchant with same last name" do
        # get :find_all, last_name: @merchant1.last_name, format: :json

        # expect(response).to have_http_status(:ok)
        # expect(json.count).to eq(2)
        # expect(json.last["last_name"]).to eq(@merchant1.last_name)
      # end
    # end
  end

  describe "GET #random" do
    it "returns an instance of merchant" do
      merchant = create(:merchant)
      create(:merchant)

      same_returned = 0
      100.times do
        get :random, format: :json
        same_returned += 1 if response["name"] == merchant.name
      end

      expect(same_returned).to be <= 90
    end
  end

  describe "GET #revenue" do
    it "returns revenue for a merchant" do
      merchant = create(:merchant)

      get :revenue, id: merchant.id, format: :json

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #favorite_customer" do
    it "returns the favorite customer for a merchant" do
      merchant = create(:merchant)

      get :favorite_customer, id: merchant.id, format: :json

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #customers_with_pending_invoices" do
    it "returns the pending invoices for a merchant" do
      merchant = create(:merchant)

      get :customers_with_pending_invoices, id: merchant.id, format: :json

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #most_revenue" do
    it "returns the most revenue for a merchant" do
      get :most_revenue, quantity: 1, format: :json

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #most_items" do
    it "returns the most items for a merchant" do
      get :most_items, quantity: 1, format: :json

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #total_revenue" do
    it "returns the most items for a merchant" do
      get :most_items, date: Time.now, format: :json

      expect(response).to have_http_status(:ok)
    end
  end
end
