class TeamPokemon < ApplicationRecord
  belongs_to :team
  belongs_to :pokemon
  has_many :team_pokemon_moves, dependent: :destroy
  has_many :moves, through: :team_pokemon_moves

  validates :nickname, presence: true

  def getMoves
    pokemon_moves = self.pokemon.moves.sample(4)
    
    pokemon_moves.each do |move|
      team_pokemon_move = Move.find_by(name: move)
      self.moves << team_pokemon_move
    end

  end
end
