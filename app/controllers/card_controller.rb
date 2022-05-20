require_relative "utils.rb"
class CardController < ApplicationController

    before_action :require_login, :check_pan_card
    def index
        @card = Card.new
    end

    def save_card
        @user = User.find(current_user.username)
        @card = Card.new
        @card.card_number = params[:card][:card_number]
        @card.card_holder_name = params[:card][:card_holder_name]
        if params[:card][:expiry] != ""
            @card.expiry = Date.parse(params[:card][:expiry][2..-1])
        else
            @card.expiry = Date.new
        end
        @card.cvv = params[:card][:cvv]
        print @card.card_number
        if @card.save
            @card.users << @user
            redirect_to "/stocks"
        else
            render :index
        end
    end

    def show_user_cards
        @user = User.find(current_user.username)
        @cards = @user.cards.page params[:page]
    end


    def show_edit_form
        begin
            @card = Card.find(params[:id])
            return render :edit_form    
        rescue ActiveRecord::RecordNotFound => exception
            return redirect_to "/cards"            
        end
    end

    def update_card
        @card = Card.find(params[:id])
        @card.card_number = params[:card][:card_number]
        @card.card_holder_name = params[:card][:card_holder_name] 
        expiry = params[:card][:expiry]
        if expiry != ""
            @card.expiry = Date.parse(expiry[2..-1])
        end 
        cvv = params[:card][:cvv] 
        if cvv != nil
            @card.cvv = params[:card][:cvv].to_i
        end
        
        @user = User.find(current_user.username)
        user_password = params[:card][:user][:password]
        if @user.valid_password?(user_password) == false
            @card.errors[:user_password] << "Invalid Password"
        else
            if @card.update(card_number: @card.card_number,card_holder_name:@card.card_holder_name,cvv:@card.cvv,expiry:@card.expiry) == false
                flash.alert = "Cannot Update Card Details"
            else
                flash.notice = "Card updated successfully"
            end
        end
        return render :edit_form
    end

    def delete_card
        print " Delete Response: #{Card.destroy(params[:id])}"
        flash.notice = "Card Deleted successfully"
        return redirect_to "/cards"
    end

    

    
end
