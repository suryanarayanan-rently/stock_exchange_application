class AddOrderStatusToStockOrder < ActiveRecord::Migration[6.1]
  def change
    add_column :stock_orders, :order_status, :boolean
  end
end
