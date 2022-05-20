FactoryBot.define do
    factory :stock_order do
      unit_price {10.00}
      no_of_shares {10}
      association :sold_by, factory: :user
      association :stock_symbol, factory: :stock
    end
end
