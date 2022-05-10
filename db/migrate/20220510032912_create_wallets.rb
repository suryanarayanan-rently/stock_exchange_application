class CreateWallets < ActiveRecord::Migration[6.1]
  def change
    create_table :wallets do |t|
      t.string :username
      t.float :balance
      t.timestamps
    end
  add_foreign_key :wallets, :users, column: :username, primary_key: "username", on_delete: :cascade
  add_index :wallets, :username
  end
end
