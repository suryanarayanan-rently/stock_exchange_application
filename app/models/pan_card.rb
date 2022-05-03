class PanCard < ApplicationRecord

    
    validates :pan_no, length: {minimum: 10, maximum: 10},presence: true, uniqueness: true
    validates :user_id, length: {minimum: 8}, presence:true, uniqueness: true

    belongs_to :user
end
