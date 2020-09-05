class CreateMoves < ActiveRecord::Migration[6.0]
  def change
    create_table :moves do |t|
      t.string :name
      t.integer :power
      t.integer :priority
      t.string :types
      t.integer :accuracy
      t.string :damage
      t.string :text

      t.timestamps
    end
  end
end
