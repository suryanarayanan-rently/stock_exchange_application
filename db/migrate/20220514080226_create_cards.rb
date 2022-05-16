class CreateCards < ActiveRecord::Migration[6.1]
  def change
    create_table :cards do |t|
      t.string :card_number
      t.string :card_holder_name
      t.integer :cvv
      t.date :expiry
      t.timestamps
    end
  end
end
