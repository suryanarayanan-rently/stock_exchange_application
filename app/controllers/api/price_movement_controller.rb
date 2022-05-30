module Api
    class PriceMovementController < Api::ApplicationController 
        def show_stock_price_movements
            stock_symbol = params[:stock_symbol]
            pm = PriceMovement.where(stock_symbol:stock_symbol)
            if pm != nil
                @price_movements = pm.page params[:page]
                render json: {price_movements:@price_movements}
            else
                render json: {price_movements:[]}
            end
        end
    end 
end