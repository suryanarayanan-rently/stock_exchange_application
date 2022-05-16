module Api
    class ApplicationController < ActionController::API
        before_action :doorkeeper_authorize!

        private

        def current_user 
            @current_user ||= User.find_by(username:doorkeeper_token[:resource_owner_id])
        end
    end
end