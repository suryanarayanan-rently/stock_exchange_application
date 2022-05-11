class AddColumnsToStockOrder < ActiveRecord::Migration[6.1]
  def change
    rename_column :stock_orders, :price, :unit_price
    add_column :stock_orders, :total_price, :float
  end
end
