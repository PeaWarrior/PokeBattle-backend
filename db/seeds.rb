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