class CreateTeamPokemons < ActiveRecord::Migration[6.0]
  def change
    create_table :team_pokemons do |t|
      t.belongs_to :team, null: false, foreign_key: true
      t.belongs_to :pokemon, null: false, foreign_key: true
      t.string :nickname
      t.boolean :shiny, default: false

      t.timestamps
    end
  end
end
