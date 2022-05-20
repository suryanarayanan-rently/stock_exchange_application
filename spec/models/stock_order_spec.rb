require "rails_helper"
RSpec.describe StockOrder, type: :model do 
    it "is valid" do
        # admin  = create(:admin_user)
        # stock = create(:stock)
        stock_order = build(:stock_order)
        stock_order.stock_symbol = stock_order.stock_symbol.symbol
        expect(stock_order).to be_valid
    end
end