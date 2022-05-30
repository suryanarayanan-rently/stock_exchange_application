FactoryBot.define do
  factory :user do
    name {"surya"}
    username {Faker::Internet.unique.email}
    password {"surya035"}
    email {Faker::Internet.unique.email}
    password_confirmation {"surya035"}
    mobile {"8428169669"}
  end
end
