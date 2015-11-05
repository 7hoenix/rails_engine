require 'rails_helper'

RSpec.describe Api::V1::ItemsController, type: :controller do
  include Controllers::JsonHelpers
  describe "GET #index" do
    it "returns all instances of item" do
      create(:item)
      create(:item)

      get :index, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.count).to eq(Item.count)
    end
  end

  describe "GET #show" do
    context "with a valid item id" do
      it "returns the associated instance of item" do
        item = create(:item)

        get :show, id: item.id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["name"]).to eq(item.name)
      end
    end

    context "with invalid item id" do
      it "doesnt return a item" do
        item = create(:item)

        get :show, id: item.id + 1, format: :json

        expect(response.body).to eq("null")
      end
    end
  end

  describe "GET #find" do
    context "with valid params" do
      it "returns the associated instance of item with id" do
        item = create(:item)

        get :find, id: item.id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["name"]).to eq(item.name)
      end

      it "returns the associated instance of item with first name" do
        item = create(:item)

        get :find, name: item.name, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["name"]).to eq(item.name)
      end

      it "returns the associated instance of item with last name" do
        item = create(:item)

        get :find, name: item.name, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["name"]).to eq(item.name)
      end
    end
  end

  describe "GET #find_all" do
    # before(:each) do
      # @item1 = create(:item, : "Justin", last_name: "Jones")
      # create(:item, first_name: "Justin", last_name: "Holzmann")
      # create(:item, last_name: "Jones")
    # end

    # context "with valid params" do
      # it "returns associated instances of item with same first name" do
        # get :find_all, first_name: @item1.first_name, format: :json

        # expect(response).to have_http_status(:ok)
        # expect(json.count).to eq(2)
        # expect(json.last["first_name"]).to eq(@item1.first_name)
      # end

      # it "returns the associated instances of item with same last name" do
        # get :find_all, last_name: @item1.last_name, format: :json

        # expect(response).to have_http_status(:ok)
        # expect(json.count).to eq(2)
        # expect(json.last["last_name"]).to eq(@item1.last_name)
      # end
    # end
  end

  describe "GET #random" do
    it "returns an instance of item" do
      item = create(:item)
      create(:item)

      same_returned = 0
      100.times do
        get :random, format: :json
        same_returned += 1 if response["name"] == item.name
      end

      expect(same_returned).to be <= 90
    end
  end

  describe "GET #invoice_items" do
    it "returns associated invoice items for this item" do
      item = create(:item)
      invoice_item1 = create(:invoice_item, item_id: item.id)
      create(:invoice_item, item_id: item.id)

      get :invoice_items, id: item.id, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.first["quantity"]).to eq(invoice_item1.quantity)
    end
  end

  describe "GET #merchant" do
    it "returns the associated merchant" do
      merchant = create(:merchant)
      item = create(:item, merchant_id: merchant.id)

      get :merchant, id: item.id, format: :json

      expect(response).to have_http_status(:ok)
      expect(json["name"]).to eq(merchant.name)
    end
  end

  describe "GET #most_revenue" do
    it "returns the most revenue for an item" do
      item = create(:item)

      get :most_revenue, id: item.id, format: :json

      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #most_items" do
    it "returns the most items for an item" do
      item = create(:item)

      get :most_items, id: item.id, format: :json

      expect(response).to have_http_status(:ok)
    end
  end
end
