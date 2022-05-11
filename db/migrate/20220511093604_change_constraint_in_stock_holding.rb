class ChangeConstraintInStockHolding < ActiveRecord::Migration[6.1]
  def change
    remove_index :stock_holdings, :username
    remove_index :stock_holdings, :stock_symbol 
    add_index :stock_holdings,[:username,:stock_symbol], unique:true
  end
end
