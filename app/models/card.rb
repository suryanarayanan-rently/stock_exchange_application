class Card < ApplicationRecord
    validates :card_number, length: {minimum: 16, maximum: 16}, presence: true
    validates :card_holder_name, numericality: false, length: {minimum: 3}, presence: true
    validates :cvv, numericality: true,length: {minimum:3,maximum: 4}

    validate :validate_expiry_is_not_in_past_or_present 

    has_many :user_cards, dependent: :destroy
    has_many :users, through: :user_cards, dependent: :destroy, primary_key: :username, foreign_key: :username

    after_destroy :destroy_user_card_record
    

    def validate_expiry_is_not_in_past_or_present
        if expiry.nil?
            errors.add(:expiry,"Expiry cannot be blank")
        elsif self.expiry.past?
            errors.add(:expiry,"Card Already Expired")
        elsif self.expiry.today?
            errors.add(:expiry,"Card Expired today")
        end
    end


    def destroy_user_card_record
        UserCard.destroy_by(card_id:self.id)
    end
end
