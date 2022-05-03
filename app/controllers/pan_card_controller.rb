class PanCardController < ApplicationController
    def index
        @pan_card  = PanCard.new
    end

    def save_pan_card
        @pan_card = PanCard.new(pan_no:params["pan_card"]["pan_no"],user_id:current_user.username)
        if @pan_card.save
            redirect_to "/stocks"
        else
            render :index
        end
    end

end
