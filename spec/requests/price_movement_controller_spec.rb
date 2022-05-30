require "rails_helper.rb"
RSpec.describe "PriceMovement API", :type => :request do 
    let(:application) {create(:application)}
    let(:user) {create(:user)}
    let(:token) {create(:access_token,application: application, resource_owner_id: user.username)}

    scenario("fetches price movemt of list of stocks") do
            get "/api/price_movements/AMZ", headers: {"Authorization": "Bearer "+token.token}
            expect(response.status).to eq(200)
    end

end