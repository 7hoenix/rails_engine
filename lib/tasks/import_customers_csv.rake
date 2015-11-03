require "csv"

namespace :import_customers_csv do
  task :create_customers => :environment do
    csv_text = File.read("./data/customers.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Customer.create!(row.to_hash)
    end
  end
end
