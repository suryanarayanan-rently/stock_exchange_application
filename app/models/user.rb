class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    self.primary_key = "username"

    validates :username, presence: true, length: {minimum: 8}, uniqueness: true
    validates :name, presence: true, length: {minimum: 2}
    validates :mobile, presence: true, length: {minimum: 10, maximum: 10}
    validates :email, presence: true, length: {minimum: 8}
    validates :password, presence: true, length: {minimum: 8}
    validates :password_confirmation,presence: true, confirmation: true
    
    #Associations
    # Only one pan card can be hold by an user
    has_one :pan_card
    has_one :wallet

end