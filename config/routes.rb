Rails.application.routes.draw do
  devise_for :users

  resources :topics, only: [:index, :new, :create, :show]

  root to: "topics#new"
end
