class TeamPokemonMove < ApplicationRecord
  belongs_to :team_pokemon
  belongs_to :move
end
