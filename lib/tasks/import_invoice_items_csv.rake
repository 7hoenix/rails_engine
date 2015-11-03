require "csv"

namespace :import_invoice_items_csv do
  task :create_invoice_items => :environment do
    csv_text = File.read("./data/invoice_items.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end
end
