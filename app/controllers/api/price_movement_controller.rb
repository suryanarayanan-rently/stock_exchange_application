module Api
    class PriceMovementController < Api::ApplicationController 
        def show_stock_price_movements
            @price_movements = PriceMovement.find_by(stock_symbol:params[:stock_symbol]).page params[:page]
            # print "Current user: #{@current_user}"
            render json: {price_movemnts:@price_movements}
        end
    end 
end