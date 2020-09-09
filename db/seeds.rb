require_relative './moves'
require_relative './pokemons'

Pokemon.destroy_all()
User.destroy_all()
Battle.destroy_all()

POKEMONS.each do |pokemon|
    Pokemon.create(pokemon)
end

MOVES.each do |move|
    Move.create(move)
end

user1 = User.create({username: 'jax', password: '123', password_confirmation: '123'})
team1 = user1.teams.create(name: 'first team')
team1.team_pokemons.create(pokemon_id: 1, nickname: 'bulby', shiny: false)
team1.team_pokemons.create(pokemon_id: 4, nickname: 'Chary', shiny: false)

user2 = User.create({username: 'max', password: '123', password_confirmation: '123'})
team1 = user2.teams.create(name: 'bluee team')
team1.team_pokemons.create(pokemon_id: 6, nickname: 'Bools', shiny: false)
team1.team_pokemons.create(pokemon_id: 9, nickname: 'Cooller', shiny: false)
