class AddAmountToWallet < ActiveRecord::Migration[6.1]
  def change
    add_column :wallets, :amount, :float
  end
end
