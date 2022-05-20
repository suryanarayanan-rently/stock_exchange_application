FactoryBot.define do
    factory :user_card do
        username {create(:user).id}
        card_id {create(:card).id}
    end
end