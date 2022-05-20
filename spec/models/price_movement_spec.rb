require "rails_helper";
RSpec.describe PriceMovement, :type => :model do
    subject {
        admin = create(:admin_user)
        user = create(:user,username:admin.email,email:admin.email)
        stock = create(:stock,created_by: admin.email)
        described_class.new(stock_symbol: stock.symbol,price: 100 ,time: Time.now.utc)
    }
    
    it "is valid with required attributes" do
        expect(subject).to be_valid
    end

    it "is invalid without stock_symbol" do
        subject.stock_symbol  = nil
        expect(subject).to_not be_valid
    end

    it "is invalid without price" do
        subject.price = nil 
        expect(subject).to_not be_valid
    end

    it "is invalid without time" do 
        subject.time = nil
        expect(subject).to_not be_valid
    end

    it "is invalid if time is in future" do
        subject.time = Faker::Time.forward(days:67)
        expect(subject).to_not be_valid
    end


    it "should belong to a stock" do
        should belong_to(:stock)
    end
end