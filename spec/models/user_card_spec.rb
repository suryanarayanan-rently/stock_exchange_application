require "rails_helper"
RSpec.describe UserCard, :type => :model do
    subject {
        create(:user_card)
    }

    it "is valid with required_attributes" do
        expect(subject).to be_valid
    end

    it "is invalid without username" do 
        subject.username  = nil
        expect(subject).to_not be_valid
    end

    it "is invalid without card_id" do
        subject.card_id = nil 
        expect(subject).to_not be_valid
    end

   
end
