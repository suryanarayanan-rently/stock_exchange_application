class CreateStockHoldings < ActiveRecord::Migration[6.1]
  def change
    create_table :stock_holdings do |t|
      t.string :username
      t.string :stock_symbol
      t.string :no_of_shares
      t.timestamps
    end

    add_foreign_key :stock_holdings, :users, primary_key: "username", column: :username, on_delete: :cascade
    add_foreign_key :stock_holdings, :stocks, primary_key: "symbol", column: :stock_symbol, on_delete: :cascade

    # add_index :stock_holdings, :username, unique: true
    # add_index :stock_holdings, :stock_symbol, unique: true
  end
end