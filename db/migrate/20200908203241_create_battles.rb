class CreateBattles < ActiveRecord::Migration[6.0]
  def change
    create_table :battles do |t|
      t.string :room_name
      t.string :status

      t.integer :red_user_id
      t.string :red_user_name
      t.json :red_team
      t.integer :red_active_pokemon

      t.integer :blue_user_id
      t.string :blue_user_name
      t.json :blue_team
      t.integer :blue_active_pokemon

      t.string :turn
      t.string :message

      t.integer :winner, default: nil

      t.timestamps
    end
  end
end
