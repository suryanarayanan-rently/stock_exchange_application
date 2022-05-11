class AddUnitsToStockOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :stock_orders, :units, :int
  end
end
