# frozen_string_literal: true

Rails.application.routes.draw do
  resources :users
  resources :wines
  resources :wineyards
  resource :session, only: [:new, :create, :destroy]
  root 'wineyards#index'
  get 'kaikki_vinkut', to: 'wines#index'
  get 'signup', to: 'users#new'
  # get 'ratings', to: 'ratings#index'
  # get 'ratings/new', to:'ratings#new'
  # post 'ratings', to: 'ratings#create'
  resources :ratings, only: %i[index new create destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
