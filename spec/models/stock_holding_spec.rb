require "rails_helper"
RSpec.describe StockHolding, :type => :model do
    subject {
        create(:stock_holding)
    }
    it "is valid with requireds attribute" do
        expect(subject).to be_valid
    end
    it "is invalid without username" do
        subject.username = nil
        expect(subject).to_not be_valid
    end
    it "is invalid with negative values" do 
        subject.no_of_shares = -1
        expect(subject).to_not be_valid
    end
    it "subject is invalid with fractional values for no_of_shares" do
        subject.no_of_shares = 5.67
        expect(subject).to_not be_valid
    end

    it "should belong to an user" do 
        should belong_to(:user)
    end

    it "should belong to a stock" do 
        should belong_to(:stock)
    end

end
