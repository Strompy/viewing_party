Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'
  get '/auth/:provider/callback', to: 'sessions#omniauth'

  post '/movies', to: 'movies#index'
  resources :movies, only:[:index, :show]
  #get '/movies', to: 'movies#index'
  #get '/movies', to: 'movies#show'

  namespace :dashboard do
    get '/', to: 'users#show'
    resources :discover, only: [:index]
    resources :friendships, only: [:create]
    resources :viewing_parties, only: [:show, :new, :create]
    resources :calendar, only: [:create]
  end

end
