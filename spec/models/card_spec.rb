require "rails_helper"
RSpec.describe Card , :type => :model do
    subject {
        create(:card)
    }

    it "is valid with required attribute" do 
        expect(subject).to be_valid
    end

    it "is invaid without card number" do
        subject.card_number  = nil
        expect(subject).to_not be_valid
    end

    it "is invalid if card_number is less than 16" do
        subject.card_number = Faker::Number.number(digits:3)
        expect(subject).to_not be_valid 
    end

    it "is invalid if card_number is greater than 16" do
        subject.card_number = Faker::Number.number(digits: 18)
        expect(subject).to_not be_valid
    end


    it "is invalid without card_holder_name" do
        subject.card_holder_name = nil
        expect(subject).to_not be_valid
    end

    it "is invalid without date" do
        subject.expiry  = nil 
       expect(subject).to_not be_valid 
    end

    it "is invalid if date is in past or present" do 
        subject.expiry = Time.parse("22-2-2020")
        expect(subject).to_not be_valid
    end

    it "is invalid witout cvv" do
        subject.cvv = nil 
        expect(subject).to_not be_valid
    end

    it "is invalid if cvv is has less 3 digits" do 
        subject.cvv = 67
        expect(subject).to_not be_valid
    end

    it "is invalid if cvv has more than 4 digits" do
        subject.cvv=98762
        expect(subject).to_not be_valid
    end

    it "should have many user cards" do 
        should have_many(:user_cards)
    end
    
    it "should have many users" do 
        should have_many(:users)
    end

    it "should destroy user card after delete" do 
        id = subject.id
        subject.destroy
        expect(UserCard.find_by_card_id(id)).to be(nil)
    end
end