module Api 
    class StockOrderController < Api::ApplicationController
        
        def save_sell_stock_order
            sold_by = @current_user.username
            units = params[:no_of_shares].to_i
            unit_price = params[:unit_price].to_f
            stock_symbol = params[:stock_symbol]
            total_price = units * unit_price
            stock_holding = StockHolding.find_by(username:@current_user.username,stock_symbol:stock_symbol)
            @stock_order = StockOrder.new(sold_by: User.find(sold_by),total_price: total_price,stock_symbol: stock_symbol,no_of_shares: units, unit_price: unit_price)
            if stock_holding == nil || stock_holding.no_of_shares < units
                @stock_order.valid?
                @stock_order.errors[:stock_holding] << "you can't sell stocks exceeding the no of units you hold"
                return render json: {errors:@stock_order.errors,msg:"please correct all the errors"}, status:400
            end
            if @stock_order.save 
                return render json: {msg:"Stock Order Successfully",stock_order:@stock_order}
            else
                
                return render json: {msg:"Cannot sell Stocks",errors:@stock_order.errors} ,status:400
            end
        end

        def buy_stock
            buyer = User.find(@current_user.username)
            begin
            stock_order = StockOrder.find(params["stockOrderId"])

            rescue ActiveRecord::RecordNotFound=> exception
                print("No recoord exists with given id")
                return render json: {error:"Invalid stock order id"}
            end
            seller = User.find(stock_order.sold_by.username)
            stock_order.valid?
            if stock_order.sold
                stock_order.errors[:sold_status]<<("This stock is already sold")
                return render json: {errors: stock_order.errors}
            end
            if stock_order.total_price > buyer.wallet.balance
                stock_order.errors[:wallet_balace]<("You don't have enough money in wallet")
                return render json: {errors: stock_order.errors}
            else
                if stock_order.update(bought_by: buyer,sold:true,sold_at: DateTime.now.utc)
                    render json: {msg: "Stock bought successfully"}, status:200
                else
                    puts "Stock Order Errors: #{stock_order.errors.to_a}"
                    render json: {errors: stock_order.errors}, status:200
                end
            end
        end

    end
end