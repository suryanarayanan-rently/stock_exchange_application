require "rails_helper"
RSpec.describe WalletController, :type => :controller do

    it "user should be redirected to '/user' if pan card is not added" do
        sign_in create(:user)
        get "show_available_cards"
        expect(response).to have_http_status(302)
        expect(response).to redirect_to("/user")
    end

    it "should redirect to user sign_in page if not logged in" do
        get "show_available_cards"
        expect(response).to have_http_status(302)
        expect(response).to redirect_to("/users/sign_in")

    end

    it "should render show_available_cards page" do
        user = create(:user)
        user.create_pan_card!(pan_no:Faker::Alphanumeric.alpha(number:10))
        
        sign_in user
        get "show_available_cards"
        expect(response).to have_http_status(200)
        expect(response).to render_template(:show_available_cards)
        expect(assigns(:cards)).to eq(user.cards)
    end

    it "adds money to wallet" do
        
        user = create(:user)
        sign_in user
        user.create_pan_card!(pan_no:Faker::Alphanumeric.alpha(number:10))
        card = create(:card)
        create(:user_card,card_id:card.id,username:user.username)
        post "add_money_to_wallet", params: {wallet: {
            cvv:card.cvv,
            card_id:card.id,
            amount:Faker::Number.number(digits:999)
        }}
        print response.redirect_url
        expect(response).to have_http_status(302)
        expect(response).to redirect_to("/stocks")
    end

    it "render sam page if error" do
        
        user = create(:user)
        sign_in user
        user.create_pan_card!(pan_no:Faker::Alphanumeric.alpha(number:10))
        card = create(:card)
        create(:user_card,card_id:card.id,username:user.username)
        post "add_money_to_wallet", params: {wallet: {
            cvv:235,
            card_id:card.id,
            amount:Faker::Number.number(digits:999)
        }}
        print response.redirect_url
        expect(response).to have_http_status(200)
        expect(response).to render_template(:show_available_cards)
    end


    

    

end