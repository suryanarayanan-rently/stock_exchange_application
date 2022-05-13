class AddStocksOnHoldToStockHolding < ActiveRecord::Migration[6.1]
  def change
    add_column :stock_holdings, :stocks_on_hold, :int, default: 0, null: false
  end
end
