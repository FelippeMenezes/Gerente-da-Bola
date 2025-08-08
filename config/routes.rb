Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Teams
  get    "/teams",          to: "teams#index"
  get    "/teams/new",      to: "teams#new",    as: :new_team
  post   "/teams",          to: "teams#create"
  get    "/teams/:id",      to: "teams#show",   as: :team
  get    "/teams/:id/edit", to: "teams#edit",   as: :edit_team
  patch  "/teams/:id",      to: "teams#update"
  put    "/teams/:id",      to: "teams#update"
  delete "/teams/:id",      to: "teams#destroy"

  # Players
  get    "/players",          to: "players#index"
  get    "/players/new",      to: "players#new",  as: :new_player
  post   "/players",          to: "players#create"
  get    "/players/:id",      to: "players#show",   as: :player
  get    "/players/:id/edit", to: "players#edit", as: :edit_player
  patch  "/players/:id",      to: "players#update"
  put    "/players/:id",      to: "players#update"
  delete "/players/:id",      to: "players#destroy"

  post   "/players/:id/list_for_sale", to: "players#list_for_sale", as: :list_for_sale_player
  post   "/players/:id/buy",           to: "players#buy",           as: :buy_player
  post   "/players/:id/sell",   to: "players#sell",   as: :sell_player

  # Matches
  get    "/matches",          to: "matches#index"
  get    "/matches/new",      to: "matches#new",  as: :new_match
  post   "/matches",          to: "matches#create"
  get    "/matches/:id",      to: "matches#show",   as: :match
  get    "/matches/:id/edit", to: "matches#edit", as: :edit_match
  patch  "/matches/:id",      to: "matches#update"
  put    "/matches/:id",      to: "matches#update"
  delete "/matches/:id",      to: "matches#destroy"

  # Market
  get "/market", to: "market#index", as: :market
end
