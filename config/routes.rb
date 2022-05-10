Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/user" => "pan_card#index", :as => :user_root
  get "/", to:"stocks#list_stocks"
  get "/user/:username" , to: "users#show_profile"
  post "/pan_cards", to: "pan_card#save_pan_card"
  get "/stocks", to: "stocks#list_stocks"
  get "/stocks/sell", to: "stock_orders#show_sell_stock_form"
  post "/stock_orders/sell", to: "stock_orders#save_sell_stock_order"
  post "/stock_orders/buy", to: "stock_orders#buy_stock"
  
end
