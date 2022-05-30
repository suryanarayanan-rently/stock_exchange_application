require "rails_helper"
RSpec.describe CardController, type: :controller do 
    subject {
        create(:user)
    }
    
    
    it "renders index page of cards" do
        subject.create_pan_card(pan_no:Faker::Alphanumeric.alpha(number:10))

        sign_in subject 
        get "index"
        expect(response).to have_http_status(200)
    end

    it "creates new card" do 
        subject.create_pan_card(pan_no:Faker::Alphanumeric.alpha(number:10))
        sign_in subject 
        card = build(:card)
        post "save_card", params: {
            card: {
                card_number: card.card_number,
                cvv:card.cvv,
                expiry:card.expiry.to_s,
                card_holder_name:subject.name
            }
        }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to("/stocks")
        
    end

    it "list available user card" do
        subject.create_pan_card(pan_no:Faker::Alphanumeric.alpha(number:10))
        sign_in subject 
        card = create(:card)
        subject.user_cards << UserCard.new(card:card)
        post "show_user_cards"
        expect(assigns(:cards)).to include(card)
    end

    it "shows edit form to user if card exists" do
        sign_in subject
        subject.create_pan_card(pan_no:Faker::Alphanumeric.alpha(number:10))
        subject.user_cards << create(:user_card,username:subject.username)
        get "show_edit_form", params: {id:subject.user_cards[0].card.id}
        print response.redirect_url
        expect(response).to have_http_status(200)
    end

    it "updates card details" do
        sign_in subject 
        subject.create_pan_card(pan_no:Faker::Alphanumeric.alpha(number:10))
        subject.user_cards << create(:user_card,username:subject.username)
        post "update_card", params: {
            id:subject.user_cards[0].card.id,
            card: {
                card_number:Faker::Alphanumeric.alpha(number: 10),
                card_holder_name: Faker::Name.name,
                expiry: subject.user_cards[0].card.expiry.to_s,
            
            user: {
                password: subject.password
            }
        }
        }
        
        expect(response).to have_http_status(200)
        expect(response).to render_template(:edit_form)
    end

    it "deletes a card" do
        sign_in subject 
        subject.create_pan_card(pan_no:Faker::Alphanumeric.alpha(number:10))
        subject.user_cards << create(:user_card,username:subject.username)
        delete "delete_card", params:{
            id: subject.user_cards[0].card.id
        }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to("/cards")
    end



end