module Api
    class StockController < Api::ApplicationController

        before_action :current_user
        def split_stock
            stock_symbol = params[:stock_symbol]
            split_times = params[:split_times]
            begin
            admin = AdminUser.find_by_email(current_user.username)
            rescue => exception
                render json: {error: "Only admin can perform this operation"}, status:403 and return
            end
            if split_times.blank? 
                render json: {error: "Split times cannot be blank"} and return
            else
                split_times = split_times.to_i
                if split_times < 0
                    render json: {error: "Split times cannot be  0"} and return
                end
            end
            
            if stock_symbol.blank?
                render json: {error: "STOCK SYMBOL cannot be blank"} and return
            end
            puts "Symbol #{stock_symbol}"
            stock = Stock.find(stock_symbol)
            stock.update(current_price:stock.current_price / params[:split_times].to_i,no_of_shares: stock.no_of_shares * params[:split_times].to_i)
            StockHolding.where(stock_symbol:stock).update_all(["no_of_shares = no_of_shares * ?, stocks_on_hold = stocks_on_hold * ?",params[:split_times].to_i,params[:split_times].to_i])
            StockOrder.where(stock_symbol:stock).update_all(["no_of_shares = no_of_shares * ?, unit_price = unit_price / ?",params[:split_times].to_i,params[:split_times].to_i])
            render json: {msg:"success"},status:200 and return
        end
    end
end