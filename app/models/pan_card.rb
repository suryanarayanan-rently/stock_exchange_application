class PanCard < ApplicationRecord
    validates :pan_no, presence: true
    belongs_to :user, foreign_key: :username
end
