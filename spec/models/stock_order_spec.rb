require "rails_helper"
RSpec.describe StockOrder, type: :model do 
    
    before(:each) do
        @admin = create(:admin_user)
        @user = User.find(@admin.email)
        @stock_order = build(:stock_order,stock:create(:stock,created_by:@user.email),sold_by:@user)
    end

    it "is valid" do
        expect(@stock_order).to be_valid
    end

    it "is invalid without unit_price" do
        @stock_order.unit_price = 0
        expect(@stock_order).to_not be_valid()
    end

    it "is invalid without sold_by" do
        @stock_order.sold_by = build(:user)
        expect(@stock_order).to_not be_valid()
    end

    it "is invalid without no_of_shares" do
        @stock_order.no_of_shares= 0
        expect(@stock_order).to_not be_valid()
    end

    it "is invalid when tring to sell more number of stocks than holding" do
        @stock_order.no_of_shares += @stock_order.stock.no_of_shares
        expect(@stock_order).to_not be_valid()
    end


    it "update stock holding on destroy" do 
        admin = create(:admin_user)
        user = User.find(admin.email)
        stock_order = create(:stock_order,stock:create(:stock,created_by:admin.email),sold_by:user)
        stock = stock_order.stock
        no_of_shares = stock.stock_holding[0].no_of_shares
        stock_holding = stock.stock_holding[0]
        stock_order.destroy
        expect(stock_holding.reload.stocks_on_hold).to eq(0)
    end
end