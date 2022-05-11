# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_05_11_105820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "drop_pan_cards", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pan_cards", primary_key: "pan_no", id: :string, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.index ["username"], name: "index_pan_cards_on_username"
  end

  create_table "stock_holdings", force: :cascade do |t|
    t.string "username"
    t.string "stock_symbol"
    t.string "no_of_shares"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["username", "stock_symbol"], name: "index_stock_holdings_on_username_and_stock_symbol", unique: true
  end

  create_table "stock_orders", force: :cascade do |t|
    t.string "sold_by"
    t.string "bought_by"
    t.string "stock_symbol"
    t.datetime "sold_at"
    t.float "unit_price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "no_of_shares"
    t.boolean "order_status"
    t.float "total_price"
  end

  create_table "stocks", primary_key: "symbol", id: :string, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "face_value"
    t.integer "no_of_shares"
    t.float "current_price"
    t.string "created_by"
  end

  create_table "users", primary_key: "username", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "mobile"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.string "username"
    t.float "balance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["username"], name: "index_wallets_on_username"
  end

  add_foreign_key "pan_cards", "users", column: "username", primary_key: "username"
  add_foreign_key "stock_holdings", "stocks", column: "stock_symbol", primary_key: "symbol"
  add_foreign_key "stock_holdings", "users", column: "username", primary_key: "username"
  add_foreign_key "stock_orders", "stocks", column: "stock_symbol", primary_key: "symbol"
  add_foreign_key "stock_orders", "users", column: "bought_by", primary_key: "username"
  add_foreign_key "stock_orders", "users", column: "sold_by", primary_key: "username"
  add_foreign_key "stocks", "admin_users", column: "created_by", primary_key: "email"
  add_foreign_key "wallets", "users", column: "username", primary_key: "username"
end
