class StockOrdersController < ApplicationController
    def new
        @stock_orders = StockOrder.new
    end
    def show_sell_stock_form
        new
        render :sell_stock
    end
    def save_sell_stock_order
        sold_by = current_user.username
        price = params[:price]
        stock_symbol = params[:stock_symbol]
        @stock_order = StockOrder.new(sold_by: User.find(sold_by),price: price.to_f,stock_symbol: stock_symbol)
        if @stock_order.save 
            redirect_to "/list_stocks"
        else
            render :sell_stock
        end
    end
end