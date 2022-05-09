class CreateStocks < ActiveRecord::Migration[6.1]
  def change
    create_table :stocks, id: false do |t|
      t.string :symbol, primary_key:true
      t.string :name

      t.timestamps
    end
  end
end
