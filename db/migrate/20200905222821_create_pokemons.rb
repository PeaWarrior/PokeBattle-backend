class CreatePokemons < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemons do |t|
      t.string :species
      t.string :types, array: true
      t.json :sprites
      t.json :stats
      t.string :moves, array: true

      t.timestamps
    end
  end
end
