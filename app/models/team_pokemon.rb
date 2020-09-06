class TeamPokemon < ApplicationRecord
  belongs_to :team
  belongs_to :pokemon
  has_many :team_pokemon_moves
  has_many :moves, through: :team_pokemon_moves

  validates :nickname, presence: true
end
