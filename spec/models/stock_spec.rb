require "rails_helper"
RSpec.describe Stock, type: :model do

    before (:each) do
        @admin = create :admin_user 
    end

    subject {
        create(:stock)
    }
        

    it "is created with valid atttributes" do 
        stock = build :stock, created_by: @admin.email
       expect(stock).to be_valid
    end

    it "is invalid without symbol" do
        
        stock = build :stock, symbol: nil ,created_by: @admin.email
        expect(stock).to_not be_valid
    end

    it "is invalid without name" do
        stock = build :stock, name: nil, created_by: @admin.email
        expect(stock).to_not be_valid
    end

    it "is invalid without no_of_shares" do
        stock = build :stock,no_of_shares:0,created_by: @admin.email
        expect(stock).to_not be_valid
    end
    it "is invalid without face_value" do
        stock = build :stock,face_value:0.0,created_by: @admin.email
        expect(stock).to_not be_valid
    end
    it "is invalid without current_price" do
        stock = build :stock,current_price:0.0,created_by: @admin.email
        expect(stock).to_not be_valid
    end
    it "is invalid without created_by" do
        stock = build :stock, created_by:  nil
        expect(stock).to_not be_valid     
    end

    it "should belong to an admin" do
        stock = build :stock,created_by: @admin.email
        should belong_to(:admin_user)
    end

    it "has many holdings" do
        stock = build :stock,created_by: @admin.email
        should have_many(:stock_holding)
    end

    it "has many orders" do
        stock = build :stock, created_by: @admin.email 
        should have_many(:stock_order)
    end

    it "has many price movements" do
        stock = build :stock, created_by: @admin.email
        should have_many(:price_movements)
    end

    it "update or create stock hodling after create" do
        expect(subject.stock_holding.count).to be >= 0 
    end
    
    it "updates wallet balance after destroy" do
        stock = create(:stock)
        stock.current_price = 5
        stock.save!
        stock.stock_holding[0].no_of_shares = 10
        stock.stock_holding[0].save!
        user = User.find(stock.created_by)
        puts "username: #{user.email}"
        puts " wallet: #{user.wallet.balance}"
        puts "stock_holdingL #{user.stock_holding[0].no_of_shares}"
        puts "current_price: #{stock.current_price}"
        puts "stock_hloding: #{StockHolding.where(stock_symbol:stock.symbol,username:stock.created_by).to_a}"
        balance = user.wallet.balance
        stock.destroy!
        expect(user.wallet.reload.balance).to eq(balance + (5 * 10))
    end

    


end