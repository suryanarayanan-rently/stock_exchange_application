class UserCard < ApplicationRecord
  belongs_to :card
  belongs_to :user, foreign_key: :username, primary_key: :username
end
