require "rails_helper"
RSpec.describe StockHoldingController, :type => :controller do
    subject {
        create(:user)
    }
    it "shows stocks" do
        sign_in subject 
        subject.create_pan_card(pan_no:Faker::Alphanumeric.alpha(number: 10))
        post "show_stocks"
        expect(assigns(:stock_holdings).count).to eq(0)
    end
end