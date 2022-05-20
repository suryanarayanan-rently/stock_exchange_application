class WalletController < ApplicationController
    before_action :require_login,:check_pan_card

    def show_available_cards
        @wallet = Wallet.new
        @user = User.find(current_user.username)
        @cards = @user.cards 
        
    end
    def add_money_to_wallet
        @wallet = Wallet.new
        @user = User.find(current_user.username)
        @cards = @user.cards
        cvv = params[:wallet][:cvv]
        amount = params[:wallet][:amount]

        if amount.blank?
            flash.alert = "Money cannot be added to wallet"
            @wallet.errors[:amount] <<  "Amount cannot be blank"
            return render :show_available_cards 
        end
        if cvv.blank?
            flash.alert = "Money cannot be added to wallet"
            @wallet.errors[:cvv] << "CVV cannot be blank"
            return render :show_available_cards
        end 

        amount = amount.to_i
        cvv = cvv.to_i

        card_id = params[:wallet][:card_id]
        card = @user.cards.find(card_id)
        if card.cvv != cvv
            flash.alert = "Money cannot be added to wallet"
            @wallet.errors[:cvv] << "Invalid CVV"
            render :show_available_cards
        else
            @user.wallet.update(balance:@user.wallet.balance + amount)
            flash.notice = "Amount of Rs.#{amount} Successfully Added"
            redirect_to "/stocks"
        end
    end
end
