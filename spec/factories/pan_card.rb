FactoryBot.define do
    factory :pan_card do
        username {create(:user)}
        pan_no {Faker::Alphanumeric.alpha(number:10).capitalize}
    end
end