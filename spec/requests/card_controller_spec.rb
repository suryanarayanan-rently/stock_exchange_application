require "rails_helper"
RSpec.describe Api::CardController ,:type => :request do

    let(:application) {create(:application)}
    let(:user) {create(:user)}
    let(:token) {create(:access_token,application:application,resource_owner_id:user.username)}
    
    it("get list of user cards") do
        get "/api/cards", headers: {"Authorization": "Bearer "+ token.token}
        puts "response #{response.body}"
        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)["cards"].count).to eq(0)
    end

    it("creates a new user card") do 
        card = build(:card)
        post "/api/card", params: {
            card: {
                card_number: card.card_number,
                card_holder_name: card.card_holder_name,
                expiry:card.expiry.to_s,
                cvv:card.cvv
            }
        },
        headers: {"authorization": "Bearer " + token.token}
        expect(response.status).to eq(200)
        body = JSON.parse(response.body)
        expect(body["msg"]).to eq("success")

        expect(body["card"]).to_not eq(nil)
    end

    it("update card details") do
        uc = UserCard.create(card:create(:card),user:user)
        put "/api/card/#{uc.card.id}", params: {
            card:{
                card_number:Faker::Number.unique.number(digits: 16),
                card_holder_name:Faker::Name.unique,
                cvv: uc.card.cvv,
                user:{
                    "password":uc.user.password
                }
            },
            id:uc.card.id,
           
        },
        headers: {
            "Authorization": "Bearer " + token.token
        }
        expect(response.status).to eq(200)
    end

    it("delete card details") do 
        uc = UserCard.create(card:create(:card),user:user)
        delete "/api/card/#{uc.card.id}",headers: {
            "Authorization":"Bearer "+ token.token
        }
        expect(response.status).to eq(200)
    end
end
