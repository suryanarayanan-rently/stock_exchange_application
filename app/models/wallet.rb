class Wallet < ApplicationRecord
    validates :username, uniqueness: true
    validates :balance, presence: true, numericality: {greater_than_or_equal_to: 0.00}
    belongs_to :user, foreign_key: :username, primary_key: :username
end
