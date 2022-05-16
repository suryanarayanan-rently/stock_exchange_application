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
    has_one :pan_card, foreign_key: :username, dependent: :destroy
    has_one :wallet, foreign_key: :username, primary_key: :username, dependent: :destroy

    has_many :stock_holding, foreign_key: :username, dependent: :destroy
    has_many :user_cards, foreign_key: :username
    has_many :cards, through: :user_cards, foreign_key: :username,  dependent: :destroy    

    def self.authenticate(username,password)
      user = User.find_for_authentication(username: username)
      user&.valid_password?(password) ? user:nil
    end
end
