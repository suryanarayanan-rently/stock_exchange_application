require_relative 'utils.rb'
class StockOrdersController < ApplicationController
    before_action :require_login,:check_pan_card
    def new
        @stock_order = StockOrder.new
    end

    def show_sell_stock_form
        new
        render :sell_stock
    end

    def list_stocks
        @user = User.find(current_user.username)
        if params[:query].blank? != true and params[:query].nil? != true

            @sellorders = StockOrder.kinda_spelled_like(params[:query]).where(sold: false).and(StockOrder.where.not(sold_by:@user)).page(params[:page]) 
        else
            @sellorders = StockOrder.where(sold: false).and(StockOrder.where.not(sold_by:@user)).page(params[:page])
        end
            puts "Sell Orders:#{@sellorders.limit_value}"
    end
    

    def save_sell_stock_order
        sold_by = current_user.username
        units = params[:no_of_shares].to_i
        unit_price = params[:unit_price].to_f
        stock_symbol = params[:stock_symbol]
        total_price = units * unit_price
        stock_holding = StockHolding.find_by(username:current_user.username,stock_symbol:stock_symbol)
        @stock_order = StockOrder.new(sold_by: User.find(sold_by),total_price: total_price,stock_symbol: stock_symbol,no_of_shares: units, unit_price: unit_price)
        if stock_holding == nil || stock_holding.no_of_shares < units
            flash.alert = "you can't sell stocks exceeding the no of units you hold"
            return render :sell_stock
        end
        if @stock_order.save 
            flash.notice = "Stocks Bought Successefully";
            redirect_to "/stocks"
        else
            flash.alert = "Cannot Buy Stocks"
            @stock_order = StockOrder.new(sold_by: User.find(sold_by),total_price: total_price,stock_symbol: stock_symbol,no_of_shares: units, unit_price: unit_price)
            render :sell_stock
        end
    end

    def buy_stock
        buyer = User.find(current_user.username)
        stock_order = StockOrder.find(params["stockOrderId"])
        seller = User.find(stock_order.sold_by.username)
        if stock_order.total_price > buyer.wallet.balance
            redirect_to "/stocks", alert:"You don't have enough money in wallet."
        else
            if stock_order.update(bought_by: buyer,sold:true,sold_at: DateTime.now.utc)
                redirect_to "/stocks", notice:"Stock bought successfully"
            else
                puts "Stock Order Errors: #{stock_order.errors.to_a}"
                redirect_to "/stocks", alert:"Stocks cannot be bought"
            end
        end
    end

    


end