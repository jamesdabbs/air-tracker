Rails.application.routes.draw do

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  resources :topics, except: [:delete] do
    member do
      post :upvote
      post :downvote
    end
  end

  namespace :api do
    namespace :v1 do
      resources :topics, only: [:index, :show]
    end
  end

  root to: "static_pages#home"
end
