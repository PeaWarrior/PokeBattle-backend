class TeamPokemon < ApplicationRecord
  belongs_to :team
  belongs_to :pokemon
  has_many :moves

  validates :nickname, uniqueness: { case_sensitive: false }
end
