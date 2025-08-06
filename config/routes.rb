Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  # Teams
  get    "/teams",          to: "teams#index"
  get    "/teams/new",      to: "teams#new"
  post   "/teams",          to: "teams#create"
  get    "/teams/:id",      to: "teams#show",   as: :team
  get    "/teams/:id/edit", to: "teams#edit"
  patch  "/teams/:id",      to: "teams#update"
  put    "/teams/:id",      to: "teams#update"
  delete "/teams/:id",      to: "teams#destroy"

  # Players
  get    "/players",          to: "players#index"
  get    "/players/new",      to: "players#new"
  post   "/players",          to: "players#create"
  get    "/players/:id",      to: "players#show",   as: :player
  get    "/players/:id/edit", to: "players#edit"
  patch  "/players/:id",      to: "players#update"
  put    "/players/:id",      to: "players#update"
  delete "/players/:id",      to: "players#destroy"

  # Matches
  get    "/matches",          to: "matches#index"
  get    "/matches/new",      to: "matches#new"
  post   "/matches",          to: "matches#create"
  get    "/matches/:id",      to: "matches#show",   as: :match
  get    "/matches/:id/edit", to: "matches#edit"
  patch  "/matches/:id",      to: "matches#update"
  put    "/matches/:id",      to: "matches#update"
  delete "/matches/:id",      to: "matches#destroy"
end
