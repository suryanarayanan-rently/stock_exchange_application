FactoryBot.define do
    factory :user_card do
        username {create(:user).username}
        card_id {create(:card).id}
    end
end