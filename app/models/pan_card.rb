class PanCard < ApplicationRecord
    validates :pan_no, presence: true
    belongs_to :user, foreign_key: :username

    after_create :create_wallet

    def create_wallet
        Wallet.create(username: self.username,balance: 100.0)
    end
end
