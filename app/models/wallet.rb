class Wallet < ApplicationRecord
    belongs_to :user, foreign_key: :username, primary_key: :username
end
