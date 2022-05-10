class CreateStockOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :stock_orders do |t|
      t.string :sold_by
      t.string :bought_by
      t.string :stock_symbol
      t.datetime :sold_at
      t.float :price

      t.timestamps
    end

    add_foreign_key :stock_orders, :users, column: :sold_by, primary_key:"username", on_delete: :cascade
    add_foreign_key :stock_orders, :users, column: :bought_by,primary_key:"username", on_delete: :cascade
    add_foreign_key :stock_orders, :stocks, column: :stock_symbol,primary_key:"symbol", on_delete: :cascade
  end
end
