class PanCardController < ApplicationController
    before_action :require_login, :only=>[:index,:save_pan_card]
    def index
        @pan_card  = PanCard.new
    end

    def save_pan_card
        
        @user = User.find(current_user.username)
        if @user.pancard
            return render "/list_stocks"
        end
        print @user.methods
        @pan_card = @user.create_pan_card!(pan_no:params["pan_card"]["pan_no"])
        redirect_to "/stocks"
        # render :index
    end

end
