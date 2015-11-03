require "csv"

namespace :import_items_csv do
  task :create_items => :environment do
    csv_text = File.read("./data/items.csv")
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Item.create!(row.to_hash)
    end
  end
end
