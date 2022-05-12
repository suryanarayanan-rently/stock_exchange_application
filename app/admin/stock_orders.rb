ActiveAdmin.register StockOrder do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :sold_by, :bought_by, :stock_symbol, :unit_price, :no_of_shares, :sold
  
  form do |f|
    f.input "sold_by" do
      f.has_many :user,
        new_record: "Sold By"
    end
    f.inputs  :bought_by, :stock_symbol, :unit_price, :no_of_shares, :sold
    f.submit
  
  end

  
  #
  # or
  #
  # permit_params do
  #   permitted = [:sold_by, :bought_by, :stock_symbol, :sold_at, :unit_price, :no_of_shares, :order_status, :total_price]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
