require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController, type: :controller do
  include Controllers::JsonHelpers
  describe "GET #index" do
    it "returns all instances of invoice_item" do
      create(:invoice_item)
      create(:invoice_item)

      get :index, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.count).to eq(InvoiceItem.count)
    end
  end

  describe "GET #show" do
    context "with a valid invoice_item id" do
      it "returns the associated instance of invoice_item" do
        invoice_item = create(:invoice_item)

        get :show, id: invoice_item.id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["quantity"]).to eq(invoice_item.quantity)
      end
    end

    context "with invalid invoice_item id" do
      it "doesnt return a invoice_item" do
        invoice_item = create(:invoice_item)

        get :show, id: invoice_item.id + 1, format: :json

        expect(response.body).to eq("null")
      end
    end
  end

  describe "GET #find" do
    context "with valid params" do
      it "returns the associated instance of invoice_item with id" do
        invoice_item = create(:invoice_item)

        get :find, id: invoice_item.id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["quantity"]).to eq(invoice_item.quantity)
      end

      it "returns the associated instance of invoice_item with first name" do
        invoice_item = create(:invoice_item)

        get :find, invoice_id: invoice_item.invoice_id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["quantity"]).to eq(invoice_item.quantity)
      end

      it "returns the associated instance of invoice_item with last name" do
        invoice_item = create(:invoice_item)

        get :find, quantity: invoice_item.quantity, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["quantity"]).to eq(invoice_item.quantity)
      end
    end
  end

  describe "GET #find_all" do
    # before(:each) do
      # @invoice_item1 = create(:invoice_item, : "Justin", last_name: "Jones")
      # create(:invoice_item, first_name: "Justin", last_name: "Holzmann")
      # create(:invoice_item, last_name: "Jones")
    # end

    # context "with valid params" do
      # it "returns associated instances of invoice_item with same first name" do
        # get :find_all, first_name: @invoice_item1.first_name, format: :json

        # expect(response).to have_http_status(:ok)
        # expect(json.count).to eq(2)
        # expect(json.last["first_name"]).to eq(@invoice_item1.first_name)
      # end

      # it "returns the associated instances of invoice_item with same last name" do
        # get :find_all, last_name: @invoice_item1.last_name, format: :json

        # expect(response).to have_http_status(:ok)
        # expect(json.count).to eq(2)
        # expect(json.last["last_name"]).to eq(@invoice_item1.last_name)
      # end
    # end
  end

  describe "GET #random" do
    it "returns an instance of invoice_item" do
      invoice_item = create(:invoice_item)
      create(:invoice_item)

      same_returned = 0
      100.times do
        get :random, format: :json
        same_returned += 1 if response["quantity"] == invoice_item.quantity
      end

      expect(same_returned).to be <= 90
    end
  end

  describe "GET #invoice" do
    it "returns associated invoice with this invoice_item" do
      invoice = create(:invoice)
      invoice_item = create(:invoice_item, invoice_id: invoice.id)
      create(:invoice)

      get :invoice, id: invoice_item.id, format: :json

      expect(response).to have_http_status(:ok)
      expect(json["id"]).to eq(invoice.id)
    end
  end

  describe "GET #item" do
    it "returns associated item" do
      item = create(:item)
      create(:item)
      invoice_item = create(:invoice_item, item_id: item.id)

      get :item, id: invoice_item.id, format: :json

      expect(response).to have_http_status(:ok)
      expect(json["name"]).to eq(item.name)
    end
  end
end
