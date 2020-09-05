class Team < ApplicationRecord
  belongs_to :user
  has_many :team_pokemons
  has_many :pokemmons, through: :team_pokemons

  validates :name, uniqueness: { case_sensitive: false }
end
