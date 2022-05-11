class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable, :authentication_keys => [:email]
  has_many :stock, foreign_key: :created_by, primary_key: "email"
end

