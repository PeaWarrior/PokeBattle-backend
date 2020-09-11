class BattleSerializer < ActiveModel::Serializer
    attributes :id, :room_name, :status, :red_team, :red_active, :blue_team, :blue_active, :turn, :message, :winner
    
    has_many :users
end