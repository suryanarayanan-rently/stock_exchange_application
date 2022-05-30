require "rails_helper"
RSpec.describe Api::StockController, :type => :request do
    let(:application) {create(:application)}
    let(:admin) {create(:admin_user)}
    let(:token) {create(:access_token,application: application, resource_owner_id: admin.email)}

    scenario("splits number of stocks") do
        stock = create(:stock,created_by:admin.email,no_of_shares:50)
        user = User.find(admin.email)
        post "/api/stocks/split/#{stock.symbol}", params:{
            stock_symbol:stock.symbol,
            split_times:2
        }, headers: {
            "Authorization": "Bearer " + token.token
        }
        expect(response).to have_http_status(200)
        expect(stock.reload.no_of_shares).to eq(100)
    end
end