require 'rails_helper'

RSpec.describe Api::V1::TransactionsController, type: :controller do
  include Controllers::JsonHelpers
  describe "GET #index" do
    it "returns all instances of transaction" do
      create(:transaction)
      create(:transaction)

      get :index, format: :json

      expect(response).to have_http_status(:ok)
      expect(json.count).to eq(Transaction.count)
    end
  end

  describe "GET #show" do
    context "with a valid transaction id" do
      it "returns the associated instance of transaction" do
        transaction = create(:transaction)

        get :show, id: transaction.id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["credit_card_number"]).to eq(transaction.credit_card_number)
      end
    end

    context "with invalid transaction id" do
      it "doesnt return a transaction" do
        transaction = create(:transaction)

        get :show, id: transaction.id + 1, format: :json

        expect(response.body).to eq("null")
      end
    end
  end

  describe "GET #find" do
    context "with valid params" do
      it "returns the associated instance of transaction with id" do
        transaction = create(:transaction)

        get :find, id: transaction.id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["credit_card_number"]).to eq(transaction.credit_card_number)
      end

      it "returns the associated instance of transaction with first name" do
        transaction = create(:transaction)

        get :find, invoice_id: transaction.invoice_id, format: :json

        expect(response).to have_http_status(:ok)
        expect(json["credit_card_number"]).to eq(transaction.credit_card_number)
      end
    end
  end

  describe "GET #find_all" do
    # before(:each) do
      # @transaction1 = create(:transaction, : "Justin", last_name: "Jones")
      # create(:transaction, first_name: "Justin", last_name: "Holzmann")
      # create(:transaction, last_name: "Jones")
    # end

    # context "with valid params" do
      # it "returns associated instances of transaction with same first name" do
        # get :find_all, first_name: @transaction1.first_name, format: :json

        # expect(response).to have_http_status(:ok)
        # expect(json.count).to eq(2)
        # expect(json.last["first_name"]).to eq(@transaction1.first_name)
      # end

      # it "returns the associated instances of transaction with same last name" do
        # get :find_all, last_name: @transaction1.last_name, format: :json

        # expect(response).to have_http_status(:ok)
        # expect(json.count).to eq(2)
        # expect(json.last["last_name"]).to eq(@transaction1.last_name)
      # end
    # end
  end

  describe "GET #random" do
    it "returns an instance of transaction" do
      transaction = create(:transaction)
      create(:transaction)

      same_returned = 0
      100.times do
        get :random, format: :json
        same_returned += 1 if response["credit_card_number"] == transaction.credit_card_number
      end

      expect(same_returned).to be <= 90
    end
  end

  describe "GET #invoice" do
    it "returns the associated invoice" do
      invoice = create(:invoice)
      transaction = create(:transaction, invoice_id: invoice.id)

      get :invoice, id: transaction.id, format: :json

      expect(response).to have_http_status(:ok)
      expect(json["customer_id"]).to eq(invoice.customer_id)
    end
  end
end
