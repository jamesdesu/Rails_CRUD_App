Rails.application.routes.draw do
  get "/games/allGames", to: "games#index"
  post "/games/addGame", to: "games#create"
  match "/games/searchGames" => "games#searchGames", :via => :get
  post "/games/updateGame/:id", to: "games#update"
  post "/games/deleteGame/:id", to: "games#destroy"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "games#invalidEndpoint"
end
