require "csv"

namespace :import_transactions_csv do
  task :create_transactions => :environment do
    csv_text = File.read("./data/transactions.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Transaction.create!(row.to_hash)
    end
  end
end
