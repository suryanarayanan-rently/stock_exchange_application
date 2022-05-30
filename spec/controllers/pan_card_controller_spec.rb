require "rails_helper.rb"

RSpec.describe PanCardController, :type => :controller do
    before(:all) do 
        @user = create(:user)
    end
    
    
    it "redirect to user to sign_in if not_signed_in" do
        get "index"
        expect(response).to have_http_status(302)
        expect(response).to redirect_to("/users/sign_in")
    end

    it "show pan_Card page if user already signed_in" do
        sign_in @user
        get "index"
        expect(response).to have_http_status(200)
    end

    it "saves pan card with required attributes" do 
        sign_in @user 
        post "save_pan_card", params:  {pan_card: {pan_no: "MMDPS0090R"}}
        expect(response).to have_http_status(302)
        expect(response).to redirect_to("/stocks")

    end
end