Rails.application.routes.draw do
  resources :wines
  resources :wineyards
  root 'wineyards#index'
  get 'kaikki_vinkut', to: 'wines#index'
  # get 'ratings', to: 'ratings#index'
  # get 'ratings/new', to:'ratings#new'
  # post 'ratings', to: 'ratings#create'
  resources :ratings, only: [:index, :new, :create, :destroy]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
