class AddColumnsToStock < ActiveRecord::Migration[6.1]
  def change
    change_table :stocks do |t|
      t.float :face_value
      t.integer :no_of_shares
      t.float :current_price
    end
  end

end
