class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable, :authentication_keys => [:email]
         
  has_many :stock, foreign_key: :created_by, primary_key: "email", dependent: :destroy

  after_create do |admin|
    user = User.new(username:admin.email,password:admin.password,email:admin.email,name:admin.email,mobile:"8693251486",password_confirmation:admin.password)
    user.save!()
    user.create_wallet!(balance:100.0)
  end

end

