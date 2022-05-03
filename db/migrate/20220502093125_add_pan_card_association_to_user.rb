class AddPanCardAssociationToUser < ActiveRecord::Migration[6.1]
  
  def change
    add_belongs_to :pan_cards, :user, type: :string, null: false
  end

end
