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

ActiveRecord::Schema.define(version: 2022_05_20_055456) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_trgm"
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

  create_table "cards", force: :cascade do |t|
    t.string "card_number"
    t.string "card_holder_name"
    t.integer "cvv"
    t.date "expiry"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "drop_pan_cards", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "oauth_access_grants", force: :cascade do |t|
    t.string "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.string "resource_owner_id"
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "pan_cards", primary_key: "pan_no", id: :string, force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.index ["username"], name: "index_pan_cards_on_username"
  end

  create_table "price_movements", force: :cascade do |t|
    t.string "stock_symbol"
    t.float "price"
    t.datetime "time"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["stock_symbol"], name: "index_price_movements_on_stock_symbol"
  end

  create_table "stock_holdings", force: :cascade do |t|
    t.string "username"
    t.string "stock_symbol"
    t.integer "no_of_shares"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "stocks_on_hold", default: 0, null: false
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
    t.boolean "sold"
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

  create_table "user_cards", force: :cascade do |t|
    t.string "username"
    t.bigint "card_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_id"], name: "index_user_cards_on_card_id"
    t.index ["username", "card_id"], name: "index_user_cards_on_username_and_card_id", unique: true
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "wallets", force: :cascade do |t|
    t.string "username"
    t.float "balance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["username"], name: "index_wallets_on_username"
  end

  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id", primary_key: "username"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id", primary_key: "username"
  add_foreign_key "pan_cards", "users", column: "username", primary_key: "username", on_delete: :cascade
  add_foreign_key "price_movements", "stocks", column: "stock_symbol", primary_key: "symbol", on_delete: :cascade
  add_foreign_key "stock_holdings", "stocks", column: "stock_symbol", primary_key: "symbol", on_delete: :cascade
  add_foreign_key "stock_holdings", "users", column: "username", primary_key: "username", on_delete: :cascade
  add_foreign_key "stock_orders", "stocks", column: "stock_symbol", primary_key: "symbol", on_delete: :cascade
  add_foreign_key "stock_orders", "users", column: "bought_by", primary_key: "username", on_delete: :cascade
  add_foreign_key "stock_orders", "users", column: "sold_by", primary_key: "username", on_delete: :cascade
  add_foreign_key "stocks", "admin_users", column: "created_by", primary_key: "email", on_delete: :cascade
  add_foreign_key "user_cards", "cards"
  add_foreign_key "user_cards", "users", column: "username", primary_key: "username", on_delete: :cascade
  add_foreign_key "wallets", "users", column: "username", primary_key: "username", on_delete: :cascade
end
