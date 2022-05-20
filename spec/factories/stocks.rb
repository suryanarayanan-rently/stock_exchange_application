FactoryBot.define do
  factory :stock do
    sequence(:symbol) { |n| "TEST STOCK #{n}" }
    name {Faker::Name.unique.name}
    face_value {Faker::Number.within(range:1..100)}
    current_price {Faker::Number.number(digits:3)}
    no_of_shares {Faker::Number.number(digits:2)}
  end
end
