class ChangeColumnNoOfSharesInStockHolding < ActiveRecord::Migration[6.1]
  def change
    change_column :stock_holdings, :no_of_shares, 'integer using CAST (no_of_shares as integer)'
  end
end
