Rails.application.routes.draw do
  resources :users, only: [:create]
  post '/login', to: 'users#login'
  get '/autologin', to: 'users#autologin'
  get '/users', to: 'users#index'
  
  get '/pokemons', to: 'pokemons#index'
  get '/pokemons/:id', to: 'pokemons#show'

  get '/teams', to: 'teams#index'
  post '/teams', to: 'teams#create'
  delete '/teams/:id', to: 'teams#delete'

  post '/addpokemon', to: 'team_pokemons#create'
  delete '/team_pokemons/:id', to: 'team_pokemons#delete'

  get '/battles', to: 'battles#index'
  get '/currentbattle', to: 'battles#show'
  post '/battles', to: 'battles#create'
  patch '/join', to: 'battles#join'
  patch '/fight', to: 'battles#fight'

  mount ActionCable.server => '/consumer'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
