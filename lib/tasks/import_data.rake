require 'csv'

# Run `rake import_data:csv_to_db` to import CSV files

namespace :import_data do
  desc "import data from CSV files"
  task csv_to_db: :environment do
    file_datatypes = {
      'db/data/customers.csv' => Customer,
      'db/data/merchants.csv' => Merchant,
      'db/data/items.csv' => Item,
      'db/data/invoices.csv' => Invoice,
      'db/data/invoice_items.csv' => InvoiceItem,
      'db/data/transactions.csv' => Transaction
    }

    file_datatypes.each do |file, datatype|
      CSV.foreach(file, headers: true) do |row|
        datatype.create!(row.to_hash)
      end
    end
  end
end
