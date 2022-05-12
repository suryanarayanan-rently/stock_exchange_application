class AddCascadeToForeignKey < ActiveRecord::Migration[6.1]
  def up
    remove_foreign_key "pan_cards", "users",column: "username"
    remove_foreign_key "stock_holdings", "stocks", column: "stock_symbol"
    remove_foreign_key "stock_holdings", "users", column: "username"
    remove_foreign_key "stock_orders",  "stocks",column: "stock_symbol"
    remove_foreign_key "stock_orders", "users" ,column: "bought_by"
    remove_foreign_key "stock_orders", "users", column: "sold_by"
    remove_foreign_key "stocks", "admin_users" , column: "created_by"
    remove_foreign_key "wallets", "users", column: "username"

    add_foreign_key "pan_cards", "users", column: "username", primary_key: "username", on_delete: :cascade
    add_foreign_key "stock_holdings", "stocks", column: "stock_symbol", primary_key: "symbol", on_delete: :cascade
    add_foreign_key "stock_holdings", "users", column: "username", primary_key: "username", on_delete: :cascade
    add_foreign_key "stock_orders", "stocks", column: "stock_symbol", primary_key: "symbol", on_delete: :cascade
    add_foreign_key "stock_orders", "users", column: "bought_by", primary_key: "username", on_delete: :cascade
    add_foreign_key "stock_orders", "users", column: "sold_by", primary_key: "username", on_delete: :cascade
    add_foreign_key "stocks", "admin_users", column: "created_by", primary_key: "email", on_delete: :cascade
    add_foreign_key "wallets", "users", column: "username", primary_key: "username", on_delete: :cascade
  end

  def down

    remove_foreign_key "pan_cards", "users",column: "username"
    remove_foreign_key "stock_holdings", "stocks", column: "stock_symbol"
    remove_foreign_key "stock_holdings", "users", column: "username"
    remove_foreign_key "stock_orders",  "stocks",column: "stock_symbol"
    remove_foreign_key "stock_orders", "users" ,column: "bought_by"
    remove_foreign_key "stock_orders", "users", column: "sold_by"
    remove_foreign_key "stocks", "admin_users" , column: "created_by"
    remove_foreign_key "wallets", "users", column: "username"


    add_foreign_key "pan_cards", "users", column: "username", primary_key: "username", on_delete: :cascade
    add_foreign_key "stock_holdings", "stocks", column: "stock_symbol", primary_key: "symbol", on_delete: :cascade
    add_foreign_key "stock_holdings", "users", column: "username", primary_key: "username", on_delete: :cascade
    add_foreign_key "stock_orders", "stocks", column: "stock_symbol", primary_key: "symbol", on_delete: :cascade
    add_foreign_key "stock_orders", "users", column: "bought_by", primary_key: "username", on_delete: :cascade
    add_foreign_key "stock_orders", "users", column: "sold_by", primary_key: "username", on_delete: :cascade
    add_foreign_key "stocks", "admin_users", column: "created_by", primary_key: "email", on_delete: :cascade
    add_foreign_key "wallets", "users", column: "username", primary_key: "username", on_delete: :cascade


  
  end

end
