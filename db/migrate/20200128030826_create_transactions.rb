class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      enable_extension 'citext'
      t.string :credit_card_number
      t.string :credit_card_expiration_date
      t.citext :result
      t.datetime :created_at
      t.datetime :updated_at
      t.references :invoice, foreign_key: true

      t.timestamps
    end
  end
end
