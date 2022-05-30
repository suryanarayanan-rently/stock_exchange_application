require "rails_helper"

RSpec.describe User, :type => :model do
    before (:all) do
        @user = User.new
    end
    
    it "is valid with required attributes" do
        expect(User.new(name:"surya",username:"pinkyponky",mobile:"8428169669",email:"pinkponky@pk.com",password:"Pinkponky24",password_confirmation: "Pinkponky24")).to be_valid
    end

    it "is invalid without name" do 
        expect(User.new(username:"pinkyponky",mobile:"8428169669",email:"pinkponky@pk.com",password:"Pinkponky24",password_confirmation: "Pinkponky24")).to_not be_valid
    end

    it "is invalid without mobile" do 
        expect(User.new(name:"surya",username:"pinkyponky",email:"pinkponky@pk.com",password:"Pinkponky24",password_confirmation: "Pinkponky24")).to_not be_valid
    end

    it "is invalid without email" do 
        expect(User.new(name:"surya",username:"pinkyponky",mobile:"8428169669",password:"Pinkponky24",password_confirmation: "Pinkponky24")).to_not be_valid
    end

    it "is invalid without password" do 
        expect(User.new(name:"surya",username:"pinkyponky",email:"pinkponky@pk.com", mobile:"8428169669",password_confirmation: "Pinkponky24")).to_not be_valid
    end

    it "is invalid without password_confirmation" do 
        expect(User.new(name:"surya",username:"pinkyponky",email:"pinkponky@pk.com", mobile:"8428169669", password:"Pinkponky24")).to_not be_valid
    end

    it "is invalid if password and password_confirmation fields don't match" do
        expect(User.new(name:"surya",username:"pinkyponky",mobile:"8428169669",email:"pinkponky@pk.com",password:"Pinkponky4",password_confirmation: "Pinkponky24")).to_not be_valid
    end

    it "is invalid without unique email" do 
        @user = User.create!(name:"surya",username:"pinkyponky",mobile:"8428169669",email:"pinkyponky@pk.com",password:"Pinkponky24",password_confirmation: "Pinkponky24")
        expect(User.new(name:"surya",username:"pinkyponky1",mobile:"8428169669",email:"pinkyponky@pk.com",password:"Pinkyponky24",password_confirmation:"Pinkyponky24")).to_not be_valid
    end

    it "is invalid without unique username" do
        @user = User.create!(name:"surya",username:"pinkyponky",mobile:"8428169669",email:"pinkyponky@pk.com",password:"Pinkponky24",password_confirmation: "Pinkponky24")
        expect(User.new(name:"surya",username:"pinkyponky",mobile:"8428169669",email:"pinkyponky1@pk.com",password:"Pinkponky24",password_confirmation: "Pinkponky24")).to_not be_valid
    end
   
    it "has one pan card" do
        should have_one(:pan_card)
    end

    it "has one wallet" do 
        should have_one(:wallet)
    end

    it "has many stock_holdings" do 
        should have_many(:stock_holding)
    end

    it "has many user_cards" do 
        should have_many(:user_cards)
    end

    it "has many cards" do 
        should have_many(:cards)
    end

    
end