namespace :load_data do
  task :import_csvs => :environment do
    Rake::Task["import_customers_csv:create_customers"].execute
    Rake::Task["import_invoice_items_csv:create_invoice_items"].execute
    Rake::Task["import_invoices_csv:create_invoices"].execute
    Rake::Task["import_items_csv:create_items"].execute
    Rake::Task["import_merchants_csv:create_merchants"].execute
    Rake::Task["import_transactions_csv:create_transactions"].execute
  end
end
