
FactoryBot.define do
    factory :application,class: "Doorkeeper::Application" do
        name {Faker::Name.unique.name}
        scopes { "" }
        redirect_uri {""}
    end
end