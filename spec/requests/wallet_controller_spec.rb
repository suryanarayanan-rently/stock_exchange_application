require "rails_helper"

RSpec.describe Api::WalletController, :type=>:request do
    let(:application) {create(:application)}
    let(:user) {create(:user)}
    let(:token)  {create(:access_token,application_id:application.id,resource_owner_id:user.username)}
    it("Adds money to wallet") do
        user.user_cards << create(:user_card,username:user.username,)
        user.create_pan_card("pan_no":Faker::Alphanumeric.unique.alpha(number:10))
        amount = Faker::Number.number(digits:5)
        put "/api/wallet/add_money", params: {
            cvv:user.user_cards[0].card.cvv,
            card_id: user.user_cards[0].card.id,
            amount:amount
        },
        headers:{
            "Authorization":"Bearer "+ token.token
        }
        expect(response.status).to eq(200)
        expect(user.wallet.balance).to eq(100+amount)
    end
end