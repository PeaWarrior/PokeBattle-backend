class Team < ApplicationRecord
  belongs_to :user
  has_many :team_pokemons, dependent: :destroy

  validates :name, length: {minimum: 3}, presence: true
end
