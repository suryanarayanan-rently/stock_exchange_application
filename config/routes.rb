Rails.application.routes.draw do
  use_doorkeeper do 
    skip_controllers :authorizations, :applications, :authorized_applications
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/user" => "pan_card#index", :as => :user_root
  get "/", to:"stock_orders#list_stocks"
  get "/user/:username" , to: "users#show_profile"
  
  post "/pan_cards", to: "pan_card#save_pan_card"
  
  get "/wallet/add_money", to:"wallet#show_available_cards"
  put "/wallet/add_money", to:"wallet#add_money_to_wallet"

  get "/card", to:"card#index"
  post "/card", to:"card#save_card"
  get "/cards", to:"card#show_user_cards"
  get "/card/edit/:id", to:"card#show_edit_form"
  put "/card/edit/:id", to: "card#update_card"
  delete "/card/delete/:id", to:"card#delete_card"
  
  
  get "/stocks", to: "stock_orders#list_stocks"
  
  get "/stock_order", to: "stock_orders#show_sell_stock_form"
  post "/stock_order", to: "stock_orders#save_sell_stock_order"
  put "/stock_orders/buy", to: "stock_orders#buy_stock"
  
  get "/stock_holdings", to:"stock_holding#show_stocks"
  
  

  namespace :api do
    
    get "/cards", to:"card#show_user_cards"
    post "/card", to:"card#save_card"
    delete "/card/:id", to:"card#delete_card"
    put "/card/:id", to:"card#update_card"
    
    get "/price_movements/:stock_symbol", to:"price_movement#show_stock_price_movements"
    
    put "/wallet/add_money", to:"wallet#add_money_to_wallet"

    post "/stocks/split/:stock_symbol", to:"stock#split_stock"

  end
end
