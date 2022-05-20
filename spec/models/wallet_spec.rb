require "rails_helper.rb"

RSpec.describe Wallet, type: :model do
    
    before (:all) do
        @user = create :user
    end

    it "is valid with required attributes" do
     wallet = build :wallet, username: @user.username
     expect(wallet).to be_valid
    end

    it "is invalid without balance" do
        wallet = build :wallet, balance: nil,username: @user.username
        expect(wallet).to_not be_valid
    end 

    it "is invalid if balance is less than 0" do
        wallet = build :wallet, balance: -3, username: @user.username 
        expect(wallet).to_not be_valid
    end

    it "should belong to one user" do
        wallet = build :wallet, balance: 100, username: @user.username 
        should belong_to(:user)
        have_many_attached(:user)
    end
end