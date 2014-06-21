Rails.application.routes.draw do
  devise_for :users

  resources :topics, only: [:index, :new, :create, :show] do
    resource :vote, only: [:create, :destroy]
  end

  root to: "topics#new"
end
