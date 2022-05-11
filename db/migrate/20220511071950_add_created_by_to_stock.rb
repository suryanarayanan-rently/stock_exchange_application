class AddCreatedByToStock < ActiveRecord::Migration[6.1]
  def change
    add_column :stocks, :created_by, :string
    add_foreign_key :stocks, :admin_users, column: :created_by, primary_key: "email", on_delete: :cascade
  end
end
