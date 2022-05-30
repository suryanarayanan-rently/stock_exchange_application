class PanCardController < ApplicationController
    before_action :require_login
    def index
        @user = User.find(current_user.username)
        if @user.pan_card != nil
            return redirect_to "/stocks"
        end
        @pan_card  = PanCard.new
    end

    def save_pan_card
        
        @user = User.find(current_user.username)
        begin
            @pan_card = PanCard.create!(pan_no:params["pan_card"]["pan_no"],user: @user)
            redirect_to "/stocks"    
        rescue => exception
            print "Exception Occured"
            print exception 
            @pan_card = PanCard.new(pan_no:params["pan_card"]["pan_no"])
            render :index
        end
        
        # render :index
    end

end
