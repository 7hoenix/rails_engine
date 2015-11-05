require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe ".revenue" do
    it "returns the total revenue for a merchant" do
      merchant = create(:merchant)
      invoice1 = create(:invoice, merchant_id: merchant.id)
      invoice2 = create(:invoice, merchant_id: merchant.id)
      invoice3 = create(:invoice, merchant_id: merchant.id)
      create(:transaction, invoice_id: invoice1.id, result: "success")
      create(:transaction, invoice_id: invoice2.id, result: "success")
      create(:transaction, invoice_id: invoice3.id, result: "failed")
      ii1 = create(:invoice_item, invoice_id: invoice1.id)
      ii2 = create(:invoice_item, invoice_id: invoice2.id)

      revenue = Merchant.find(merchant.id).revenue id: merchant.id

      calculated_revenue = [ii1, ii2].reduce(0) do |sum, ii|
        sum + (ii.quantity * ii.unit_price)
      end

      expect(revenue).to eq(calculated_revenue)
    end
  end

  describe ".revenue_by_date" do
    it "returns the total revenue for a merchant for a given day" do
      date = Date.today
      merchant = create(:merchant)
      invoice1 = create(:invoice, merchant_id: merchant.id)
      invoice2 = create(:invoice, merchant_id: merchant.id, created_at:
        date)
      invoice3 = create(:invoice, merchant_id: merchant.id)
      create(:transaction, invoice_id: invoice1.id, result: "success")
      create(:transaction, invoice_id: invoice2.id, result: "success")
      create(:transaction, invoice_id: invoice3.id, result: "failed")
      create(:invoice_item, invoice_id: invoice1.id)
      ii2 = create(:invoice_item, invoice_id: invoice2.id)

      revenue_by_date = Merchant.revenue_by_date id: merchant.id, date: date
      calculated_revenue = [ii2].reduce(0) do |sum, ii|
        sum + (ii.quantity * ii.unit_price)
      end

      expect(revenue_by_date).to eq(calculated_revenue)
    end
  end

  describe ".favorite_customer" do
    it "returns the customer who has conducted most successful transactions" do
      merchant = create(:merchant)
      customer1 = create(:customer)
      customer2 = create(:customer)
      invoice1 = create(:invoice, customer_id: customer1.id, merchant_id:
        merchant.id)
      invoice2 = create(:invoice, customer_id: customer1.id, merchant_id:
        merchant.id)
      invoice3 = create(:invoice, customer_id: customer2.id, merchant_id:
        merchant.id)
      invoice4 = create(:invoice, customer_id: customer2.id, merchant_id:
        merchant.id)
      create(:transaction, invoice_id: invoice1.id, result: "success")
      create(:transaction, invoice_id: invoice2.id, result: "sucess")
      create(:transaction, invoice_id: invoice3.id, result: "success")
      create(:transaction, invoice_id: invoice4.id, result: "failed")

      favorite_customer = Merchant.favorite_customer id: merchant.id

      expect(favorite_customer.first.id).to eq(customer1.id)
    end
  end
end
