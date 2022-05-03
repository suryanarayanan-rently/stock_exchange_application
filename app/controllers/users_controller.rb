class UsersController < ApplicationController
    
    def index
        @user = User.new
    end

    def create_user
        @user = User.new(username:params["user"]["username"],name:params["user"]["name"],mobile:params["user"]["mobile"],email:params["user"]["email"],password:params["user"]["password"],password_confirmation:params["user"]["password_confirmation"])
        if !@user.save
            render :index
        else
            print "Created User Successfully"
            redirect_to "/stocks"
        end
    end

    def show_profile
        
        @user = User.find(params[:username])
        if @user == nil
            render :index 
        end
    end          
    
end