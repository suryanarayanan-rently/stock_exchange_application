FactoryBot.define do
    factory :wallet do
        balance { 100.0 }
        user {create(:user)}
    end
end