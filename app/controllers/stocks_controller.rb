require_relative 'utils.rb'
class StocksController < ApplicationController 
    before_action :require_login,:check_pan_card

    def list_stocks
        @user = User.find(current_user.username)
        @sellorders = StockOrder.all.page params[:page]
        puts "Sell Orders:#{@sellorders.limit_value}"
    end

    def show_sell_stock_form
        @stock_order = StockOrder.new
        render :sell_stock
    end
end
