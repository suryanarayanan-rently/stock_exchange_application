class AddUnqiuenessToPanCardFields < ActiveRecord::Migration[6.1]
  def change
    add_index :pan_cards, [:pan_no],unique:true
    remove_index :pan_cards, [:user_id]
    add_index :pan_cards, [:user_id],unique:true
  end
end
