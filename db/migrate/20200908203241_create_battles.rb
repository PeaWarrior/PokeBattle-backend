class CreateBattles < ActiveRecord::Migration[6.0]
  def change
    create_table :battles do |t|
      t.string :room_name
      t.string :status

      t.json :red_team
      t.integer :red_active, default: 0

      t.json :blue_team
      t.integer :blue_active, default: 0

      t.string :turn
      t.string :message

      t.integer :winner, default: nil

      t.timestamps
    end
  end
end
