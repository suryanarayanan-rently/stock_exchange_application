class PanCard < ApplicationRecord
    belongs_to :user, foreign_key: :username
end
