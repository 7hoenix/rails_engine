require "csv"

namespace :import_invoices_csv do
  task :create_invoices => :environment do
    csv_text = File.read("./data/invoices.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Invoice.create!(row.to_hash)
    end
  end
end
