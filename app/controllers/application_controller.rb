class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    private
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up,keys: [:username, :mobile, :name,:email])
    end


    protected
    def require_login
        unless user_signed_in?
            redirect_to new_user_session_path
        end
    end
end
