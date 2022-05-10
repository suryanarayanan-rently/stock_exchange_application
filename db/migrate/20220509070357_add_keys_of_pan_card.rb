class AddKeysOfPanCard < ActiveRecord::Migration[6.1]
  def change
    add_foreign_key :pan_cards, :users, column: :username, primary_key: "username", on_delete: :cascade
    add_index :pan_cards, :username
    remove_column :pan_cards, :pan_no, :string
    add_column :pan_cards, :pan_no, :string, primary_key: true
  end

end
