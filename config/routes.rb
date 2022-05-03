Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "/user" => "pan_card#index", :as => :user_root
  get "/user/:username" , to: "users#show_profile"
  post "/pan_cards", to: "pan_card#save_pan_card"
  get "/stocks", to: "stocks#list_stocks"
  
end
