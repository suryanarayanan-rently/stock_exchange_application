 FactoryBot.define do
    factory :stock_holding do
        stock_symbol {create(:stock).symbol}
        username {Stock.find(stock_symbol).created_by}
        no_of_shares  {Faker::Number.unique.number(digits:3)}
    end
end