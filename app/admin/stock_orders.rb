ActiveAdmin.register StockOrder do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :sold_by, :bought_by, :stock_symbol, :sold_at, :unit_price, :no_of_shares, :sold, :total_price, :order_status
  # form do |f|
  #   f.semantic_errors
  #   f.inputs :sold_by, :bought_by, :stock_symbol, :unit_price, :no_of_shares, :sold, :total_price, :order_status
  #   f.actions
  # end
  #
  # or
  #
  # permit_params do
  #   permitted = [:sold_by, :bought_by, :stock_symbol, :sold_at, :unit_price, :no_of_shares, :sold, :total_price, :order_status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  controller do
    def create
      @stock_order = StockOrder.new
      @stock_order.sold_by = User.find(params["stock_order"][:sold_by])
      
      if !params["stock_order"]["bought_by"].blank?
        @stock_order.bought_by = User.find(params["stock_order"][:bought_by])
      end
      @stock_order.stock_symbol = params[:stock_order][:stock_symbol]
      @stock_order.sold = params[:stock_order][:sold] == "1"
      @stock_order.unit_price = params[:stock_order][:unit_price].to_f
      @stock_order.no_of_shares = params[:stock_order][:no_of_shares].to_i
      puts "\n no_of_shares: #{@stock_order.no_of_shares} \n"
      # build_resource
      @stock_order.save!
      # create!
      flash.notice = "Record Created"
      return redirect_to "/admin/stock_orders/#{@stock_order.id}"
    end

    def update
      @stock_order = StockOrder.find(params[:id])
      @stock_order.stock_symbol = params[:stock_order][:stock_symbol]
      @stock_order.sold = params[:stock_order][:sold] == "1"
      @stock_order.unit_price = params[:stock_order][:unit_price].to_f
      @stock_order.no_of_shares = params[:stock_order][:no_of_shares].to_i
      @stock_order.save!
      flash.notice = "Successfully updated the stock order"
      return redirect_to "/admin/stock_orders/#{@stock_order.id}"
      
    end
  end
  
end
