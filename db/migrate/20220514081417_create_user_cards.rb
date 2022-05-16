class CreateUserCards < ActiveRecord::Migration[6.1]
  def change
    create_table :user_cards do |t|
      t.string :username
      t.references :card, null: false, foreign_key: true, on_delete: :cascade
      t.timestamps
    end

    add_foreign_key :user_cards, :users, column: :username, primary_key: "username", on_delete: :cascade
    add_index :user_cards, [:username,:card_id], unique:true
  end
end
