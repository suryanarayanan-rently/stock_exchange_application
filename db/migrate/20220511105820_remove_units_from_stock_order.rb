class RemoveUnitsFromStockOrder < ActiveRecord::Migration[6.1]
  def change
    remove_column :stock_orders, :units, :int
  end
end
