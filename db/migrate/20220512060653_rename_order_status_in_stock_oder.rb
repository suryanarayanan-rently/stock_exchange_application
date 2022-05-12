class RenameOrderStatusInStockOder < ActiveRecord::Migration[6.1]
  def change
    rename_column :stock_orders,:order_status,:sold
  end
end
