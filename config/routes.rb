# frozen_string_literal: true

Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create_oauth'
  resources :styles
  resources :memberships
  resources :wine_clubs
  resources :users
  resources :wines
  resources :wineyards
  resource :session, only: [:new, :create, :destroy]
  root 'wineyards#index'
  get 'wineyardlist', to:'wineyards#list'
  get 'winelist', to:'wines#list'
  get 'kaikki_vinkut', to: 'wines#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  resources :places, only: [:index, :show]
  # mikä generoi samat polut kuin seuraavat kaksi
  # get 'places', to:'places#index'
  # get 'places/:id', to:'places#show'
  post 'places', to:'places#search'
  resources :ratings, only: [:index, :new, :create, :destroy]
  # get 'ratings', to: 'ratings#index'
  # get 'ratings/new', to:'ratings#new'
  # post 'ratings', to: 'ratings#create'
  resources :wineyards do
    post 'toggle_activity', on: :member
  end
  resources :users do
    post 'toggle_useractivity', on: :member
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
