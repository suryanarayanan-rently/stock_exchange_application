class StocksController < ApplicationController 
    before_action :require_login

    def list_stocks
        @user = User.find(current_user.username)
        @sellorders = StockOrder.where(bought_by:nil).and(StockOrder.where.not(sold_by:@user.username))  
    end

    def show_sell_stock_form
        @stock_order = StockOrder.new
        render :sell_stock
    end
end
