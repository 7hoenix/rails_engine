require 'rails_helper'

RSpec.describe Api::V1::InvoicesController, type: :controller do
  include Controllers::JsonHelpers
  describe "GET #index" do
    it "returns all instances of invoice" do
      create(:invoice)
      create(:invoice)

      get :index, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.count).to eq(Invoice.count)
    end
  end

  describe "GET #show" do
    context "with a valid invoice id" do
      it "returns the associated instance of invoice" do
        invoice = create(:invoice)

        get :show, id: invoice.id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["merchant_id"]).to eq(invoice.merchant_id)
      end
    end

    context "with invalid invoice id" do
      it "doesnt return a invoice" do
        invoice = create(:invoice)

        get :show, id: invoice.id + 1, format: :json

        expect(response.body).to eq("null")
      end
    end
  end

  describe "GET #find" do
    context "with valid params" do
      it "returns the associated instance of invoice with id" do
        invoice = create(:invoice)

        get :find, id: invoice.id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["merchant_id"]).to eq(invoice.merchant_id)
      end

      it "returns the associated instance of invoice with first name" do
        invoice = create(:invoice)

        get :find, customer_id: invoice.customer_id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["merchant_id"]).to eq(invoice.merchant_id)
      end

      it "returns the associated instance of invoice with last name" do
        invoice = create(:invoice)

        get :find, merchant_id: invoice.merchant_id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["customer_id"]).to eq(invoice.customer_id)
      end
    end
  end

  describe "GET #find_all" do
    # before(:each) do
      # @invoice1 = create(:invoice, : "Justin", last_name: "Jones")
      # create(:invoice, first_name: "Justin", last_name: "Holzmann")
      # create(:invoice, last_name: "Jones")
    # end

    # context "with valid params" do
      # it "returns associated instances of invoice with same first name" do
        # get :find_all, first_name: @invoice1.first_name, format: :json

        # expect(response).to have_http_status(:ok)
        # expect(json.count).to eq(2)
        # expect(json.last["first_name"]).to eq(@invoice1.first_name)
      # end

      # it "returns the associated instances of invoice with same last name" do
        # get :find_all, last_name: @invoice1.last_name, format: :json

        # expect(response).to have_http_status(:ok)
        # expect(json.count).to eq(2)
        # expect(json.last["last_name"]).to eq(@invoice1.last_name)
      # end
    # end
  end

  describe "GET #random" do
    it "returns an instance of invoice" do
      invoice = create(:invoice)
      create(:invoice)

      same_returned = 0
      100.times do
        get :random, format: :json
        same_returned += 1 if response["merchant_id"] == invoice.merchant_id
      end

      expect(same_returned).to be <= 90
    end
  end

  describe "GET #transactions" do
    it "returns associated transactions for this invoice" do
      invoice = create(:invoice)
      transaction = create(:transaction, invoice_id: invoice.id)
      create(:transaction, invoice_id: invoice.id)
      create(:transaction)

      get :transactions, id: invoice.id, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.first["credit_card_number"]).to eq(transaction.credit_card_number)
    end
  end

  describe "GET #invoice_items" do
    it "returns associated invoice items" do
      invoice = create(:invoice)
      invoice_item = create(:invoice_item, invoice_id: invoice.id)
      create(:invoice_item, invoice_id: invoice.id)
      create(:invoice_item)

      get :invoice_items, id: invoice.id, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.first["item_id"]).to eq(invoice_item.item_id)
    end
  end

  describe "GET #items" do
    it "returns associated items" do
      invoice = create(:invoice)
      item1 = create(:item)
      item2 = create(:item)
      create(:invoice_item, item_id: item1.id, invoice_id: invoice.id)
      create(:invoice_item, item_id: item2.id, invoice_id: invoice.id)

      get :items, id: invoice.id, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.first["name"]).to eq(item1.name)
    end
  end

  describe "GET #customer" do
    it "returns the associated customer" do
      customer = create(:customer)
      invoice = create(:invoice, customer_id: customer.id)

      get :customer, id: invoice.id, format: :json

      expect(response).to have_http_status(:ok)
      expect(json["first_name"]).to eq(customer.first_name)
    end
  end

  describe "GET #merchant" do
    it "returns the associated merchant" do
      merchant = create(:merchant)
      invoice = create(:invoice, merchant_id: merchant.id)

      get :merchant, id: invoice.id, format: :json

      expect(response).to have_http_status(:ok)
      expect(json["name"]).to eq(merchant.name)
    end
  end
end
