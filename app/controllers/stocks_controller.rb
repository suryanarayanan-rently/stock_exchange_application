require_relative 'utils.rb'
class StocksController < ApplicationController 
    before_action :require_login,:check_pan_card


    def show_sell_stock_form
        @stock_order = StockOrder.new
        render :sell_stock
    end
end
