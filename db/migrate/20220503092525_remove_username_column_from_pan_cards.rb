class RemoveUsernameColumnFromPanCards < ActiveRecord::Migration[6.1]
  def change
    remove_column :pan_cards, :username
  end
end
