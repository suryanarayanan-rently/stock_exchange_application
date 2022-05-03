class CreatePanCards < ActiveRecord::Migration[6.1]
  def change
    create_table :pan_cards, id: false do |t|
      t.string :pan_no, primary_key: true
      t.string :username

      t.timestamps
    end
  end
end
