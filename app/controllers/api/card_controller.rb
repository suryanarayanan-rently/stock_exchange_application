module Api
    class CardController < Api::ApplicationController 
        
        before_action :current_user

        def show_user_cards
            cards = @current_user.cards.page params[:page]
            render json: {:cards=> cards}
        end

        def save_card
            @user = User.find(@current_user.username)
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
                render json: {:msg => :success,:card =>@card}
            else
                render json: @card.errors
            end
        end

        def delete_card
            card = Card.destroy(params[:id])
            print " Delete Response: #{card}"
            render json: {:card=>card, :message=>"Card Deletion Successful"}
        end

        def update_card
            begin
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
                
                @user = User.find(@current_user.username)
                user_password = params[:card][:user][:password]
                if @user.valid_password?(user_password) == false
                    @card.errors[:user_password] << "Invalid Password"
                    return @card.errors
                else        
                    if @card.update(card_number: @card.card_number,card_holder_name:@card.card_holder_name,cvv:@card.cvv,expiry:@card.expiry) == false
                        render json:{ "errors":@card.errors,"msg":"Cannot Update Card Details"}
                    else
                        render json:{:msg=> "Card updated successfully"}
                    end
                end
            rescue ActiveRecord::RecordNotFound => exception
                render json: {:msg=> "Resource Not found"}
            end
        end
    end
end