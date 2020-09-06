class CreateTeamPokemonMoves < ActiveRecord::Migration[6.0]
  def change
    create_table :team_pokemon_moves do |t|
      t.belongs_to :team_pokemon, null: false, foreign_key: true
      t.belongs_to :move, null: false, foreign_key: true

      t.timestamps
    end
  end
end
