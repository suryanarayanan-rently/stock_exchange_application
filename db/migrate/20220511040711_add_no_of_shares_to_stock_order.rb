class AddNoOfSharesToStockOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :stock_orders, :no_of_shares, :float
  end
end
