class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: false do |t|
      t.string :username, primary_key: true
      t.string :password
      t.string :email
      t.string :name
      t.string :mobile

      t.timestamps
    end
  end
end
