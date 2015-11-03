require 'rails_helper'

RSpec.describe Api::V1::CustomersController, type: :controller do

  include Controllers::JsonHelpers
  describe "GET #index" do
    it "returns all instances of customer" do
      create(:customer)
      create(:customer)

      get :index, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.count).to eq(Customer.count)
    end
  end

  describe "GET #show" do
    context "with a valid customer id" do
      it "returns the associated instance of customer" do
        customer = create(:customer)

        get :show, id: customer.id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["first_name"]).to eq(customer.first_name)
      end
    end

    context "with invalid customer id" do
      it "doesnt return a customer" do
        customer = create(:customer)

        get :show, id: customer.id + 1, format: :json

        expect(response.body).to eq("null")
      end
    end
  end

  describe "GET #find" do
    context "with valid params" do
      it "returns the associated instance of customer with id" do
        customer = create(:customer)

        get :find, id: customer.id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["first_name"]).to eq(customer.first_name)
      end

      it "returns the associated instance of customer with first name" do
        customer = create(:customer)

        get :find, first_name: customer.first_name, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["first_name"]).to eq(customer.first_name)
      end

      it "returns the associated instance of customer with last name" do
        customer = create(:customer)

        get :find, last_name: customer.last_name, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["first_name"]).to eq(customer.first_name)
      end
    end
  end

  describe "GET #find_all" do
    before(:each) do
      @customer1 = create(:customer, first_name: "Justin", last_name: "Jones")
      create(:customer, first_name: "Justin", last_name: "Holzmann")
      create(:customer, last_name: "Jones")
    end

    context "with valid params" do
      it "returns associated instances of customer with same first name" do
        get :find_all, first_name: @customer1.first_name, format: :json

        expect(response).to have_http_status(:ok)
        expect(json.count).to eq(2)
        expect(json.last["first_name"]).to eq(@customer1.first_name)
      end

      it "returns the associated instances of customer with same last name" do
        get :find_all, last_name: @customer1.last_name, format: :json

        expect(response).to have_http_status(:ok)
        expect(json.count).to eq(2)
        expect(json.last["last_name"]).to eq(@customer1.last_name)
      end
    end
  end

  describe "GET #random" do
    it "returns an instance of customer" do
      customer = create(:customer)
      create(:customer)

      same_returned = 0
      100.times do
        get :random, format: :json
        same_returned += 1 if response["first_name"] == customer.first_name
      end

      expect(same_returned).to be <= 90
    end
  end

  describe "GET #invoices" do
    it "returns all invoices associated with this customer" do
      customer = create(:customer)
      create(:invoice, customer_id: customer.id)
      invoice = create(:invoice, customer_id: customer.id)
      create(:invoice)

      get :invoices, id: customer.id, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.count).to eq(2)
      expect(json.last["merchant_id"]).to eq(invoice.merchant_id)
    end
  end

  describe "GET #transactions" do
    it "returns all transactions associated with this customer" do
      customer = create(:customer)
      invoice1 = create(:invoice, customer_id: customer.id)
      invoice2 = create(:invoice, customer_id: customer.id)
      create(:transaction, invoice_id: invoice1.id)
      transaction = create(:transaction, invoice_id: invoice2.id)
      create(:transaction)

      get :transactions, id: customer.id, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.count).to eq(2)
      expect(json.last["credit_card_number"]).to eq(transaction.credit_card_number)
    end
  end
end
