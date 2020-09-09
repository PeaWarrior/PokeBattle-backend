Rails.application.routes.draw do
  resources :users, only: [:create]
  post '/login', to: 'users#login'
  get '/autologin', to: 'users#autologin'
  get '/users', to: 'users#index'
  
  get '/pokemons', to: 'pokemons#index'

  get '/teams', to: 'teams#index'
  post '/teams', to: 'teams#create'
  delete '/teams/:id', to: 'teams#delete'

  post '/addpokemon', to: 'team_pokemons#create'
  delete '/team_pokemons/:id', to: 'team_pokemons#delete'

  get '/battles', to: 'battles#index'
  post '/battles', to: 'battles#create'

  mount ActionCable.server => '/consumer'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
