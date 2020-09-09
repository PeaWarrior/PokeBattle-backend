class CreateUserBattles < ActiveRecord::Migration[6.0]
  def change
    create_table :user_battles do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :battle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
