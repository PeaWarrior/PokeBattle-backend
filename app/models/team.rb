class Team < ApplicationRecord
  belongs_to :user
  has_many :team_pokemons, dependent: :destroy

  validates :name, uniqueness: { case_sensitive: false }
end
