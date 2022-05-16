class CreatePriceMovements < ActiveRecord::Migration[6.1]
  def change
    create_table :price_movements do |t|
      t.string :stock_symbol
      t.float :price
      t.datetime :time

      t.timestamps
    end
    add_foreign_key :price_movements, :stocks, column: :stock_symbol, primary_key: :symbol, on_delete: :cascade
    add_index :price_movements, :stock_symbol
  end
end
