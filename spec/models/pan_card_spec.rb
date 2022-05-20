require "rails_helper"
RSpec.describe PanCard, :type => :model do
    

    before(:all) do
        @user = User.create!(username:"admin@example.com",email: 'admin@example.comple', password:"password",password_confirmation:"password",name: "Admin", mobile:"8428169669")
    end

    subject {
        described_class.new(
            pan_no: "TESTPAN89R",
            username: "admin@example.com"
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
        expect(should belong_to(:user))
    end

    after(:all) do
        @user.destroy
    end
end