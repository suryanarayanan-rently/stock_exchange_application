require_relative 'utils.rb'
class StockOrdersController < ApplicationController
    before_action :check_pan_card,:require_login
    def new
        @stock_order = StockOrder.new
    end

    def show_sell_stock_form
        new
        render :sell_stock
    end

    def save_sell_stock_order
        sold_by = current_user.username
        units = params[:units]
        unit_price = params[:unit_price]
        stock_symbol = params[:stock_symbol]
        total_price = units * units_price
        stock_holding = StockHolding.where(username:current_user.username,stock_symbol:stock_symbol)
        if stock_holding == nil || stock_holding.no_of_shares < units
            flash.alert "you can't sell stocks exceeding the no of units you hold"
            return render :sell_stock
        end
        @stock_order = StockOrder.new(sold_by: User.find(sold_by),total_price: total_price,stock_symbol: stock_symbol,units: units, unit_price: unit_price)
        if @stock_order.save 
            redirect_to "/stocks"
        else
            render :sell_stock
        end
    end

    def buy_stock
        buyer = User.find(current_user.username)
        stock_order = StockOrder.find(params["stockOrderId"])
        seller = User.find(stock_order.sold_by.username)
        if stock_order.price > buyer.wallet.balance
            redirect_to "/stocks", alert:"You don't have enough money in wallet."
        else
            buyer.wallet.update(balance: buyer.wallet.balance - stock_order.price)
            seller.wallet.update(balance: seller.wallet.balance + stock_order.price)
            stock_order.update(bought_by: buyer.username,sold_at: DateTime.now)
            redirect_to "/stocks", alert:"Stocck bought successfully"
        end
    end

    


end