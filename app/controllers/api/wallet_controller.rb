module Api
    class WalletController < Api::ApplicationController

        def add_money_to_wallet
            @wallet = Wallet.new
            current_user
            @user = User.find(@current_user.username)
            @cards = @user.cards
            cvv = params[:cvv]
            amount = params[:amount]

            if amount.blank?
                @wallet.errors[:amount] <<  "Amount cannot be blank"
                return render json: {errors:@wallet.errors}, status: 400
            end
            if cvv.blank?
                @wallet.errors[:cvv] << "CVV cannot be blank"
                return render json: {errors:@wallet.errors}, status: 400
            end 

            amount = amount.to_i
            cvv = cvv.to_i

            card_id = params[:card_id]
            card = @user.cards.find(card_id)
            if card.cvv != cvv
                @wallet.errors[:cvv] << "Invalid CVV"
                return render json: {errors:@wallet.errors}, status: 400
            else
                @user.wallet.update(balance:@user.wallet.balance + amount)
                return render json: {msg:"success"}, status:200
            end
        end              
    end
end
