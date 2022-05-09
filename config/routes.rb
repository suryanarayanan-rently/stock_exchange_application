Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/user" => "stocks#list_stocks", :as => :user_root
  get "/user/:username" , to: "users#show_profile"
  post "/pan_cards", to: "pan_card#save_pan_card"
  get "/stocks", to: "stocks#list_stocks"
  get "/stocks/sell", to: "stock_orders#show_sell_stock_form"
  post "/stocks/sell", to: "stock_orders#save_sell_stock_order"
  
  
end
