require_relative './moves'
require_relative './pokemons'

Pokemon.destroy_all()
User.destroy_all()

POKEMONS.each do |pokemon|
    Pokemon.create(pokemon)
end

MOVES.each do |move|
    Move.create(move)
end

user1 = User.create({username: 'jax', password: '123', password_confirmation: '123'})
team1 = user1.teams.create(name: 'first team')
user1.update(activeTeam: 1)
team1.team_pokemons.create(pokemon_id: 1, nickname: 'bulby', shiny: false)