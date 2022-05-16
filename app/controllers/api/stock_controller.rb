module Api
    class StockController < Api::ApplicationController

        before_action :current_user
        def split_stock
            stock_symbol = params[:stock_symbol]
            split_times = params[:split_times]

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

            

        end
    end
end