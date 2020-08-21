Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'
  get '/auth/:provider/callback', to: 'sessions#omniauth'
  
  resources :movies, only:[:index, :show]
  #get '/movies', to: 'movies#index'
  #get '/movies', to: 'movies#show'

  namespace :dashboard do
    get '/', to: 'users#show'
    get '/discover', to: 'discover#index'
  end
end
