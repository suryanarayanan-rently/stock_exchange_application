class RegistrationController < Devise::RegistrationsController
    private
        def sign_up_params()
            params.require(:user).permit(:username,:name,:email,:mobile,:password,:password_confirmation)
        end