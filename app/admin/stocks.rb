ActiveAdmin.register Stock do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :symbol, :name, :face_value, :current_price, :no_of_shares, :created_by

  form do |f|
    f.semantic_errors
    f.inputs :symbol, :name, :face_value, :current_price, :no_of_shares
    f.hidden_field :created_by, value: current_admin_user.email
    f.submit
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:symbol, :name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
