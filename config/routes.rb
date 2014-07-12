Rails.application.routes.draw do

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }

  match '/profile/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  resources :topics, only: [:index, :new, :create, :show] do
    resource :vote, only: [:create, :destroy] do
    	patch 'downvote'
    	patch 'upvote'
    end
  end

  root to: "topics#index"
end
