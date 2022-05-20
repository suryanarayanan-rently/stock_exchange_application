require "rails_helper"
RSpec.describe StockOrder, type: :model do 
    it "is valid" do
        
        stock_order = build(:stock_order)
        expect(stock_order).to be_valid
        
    end
end