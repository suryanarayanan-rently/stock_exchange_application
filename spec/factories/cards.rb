FactoryBot.define do
    factory :card do
        card_number {Faker::Number.unique.number(digits:16)}
        card_holder_name {Faker::Name.unique.name}
        expiry {Faker::Time.forward(days:Faker::Number.unique.number(digits:3))}
        cvv {Faker::Number.unique.number(digits:3)}
    end
end
