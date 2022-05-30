require "rails_helper"
RSpec.describe PanCard, :type => :model do
    

    before(:all) do
        @user = create(:user)
    end

    subject {
        described_class.new(
            pan_no: "TESTPAN89R",
            username: @user.username
        )
    }
    it "is valid with required attributes" do 
        expect(subject).to be_valid
    end

    it "is invalid without pan_no" do
        subject.pan_no = nil
        expect(subject).to_not be_valid 
    end

    it "is invalid without user" do
        subject.user = nil
        expect(subject).to_not be_valid
    end

    it "should belong to a user" do
        should belong_to(:user)
    end

    it "creates a wallet after save" do
        subject.save!
        expect(subject.user.wallet).to_not eq(nil)
    end

    after(:all) do
        @user.destroy
    end
end