Rails.application.routes.draw do
  resources :wines
  resources :wineyards
  root 'wineyards#index'
  get 'kaikki_vinkut', to: 'wines#index'
  get 'ratings', to: 'ratings#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
