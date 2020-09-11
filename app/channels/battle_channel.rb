class BattleChannel < ApplicationCable::Channel

  def subscribed
    battle = Battle.find(params['battle'])

    stream_for battle
    BattleChannel.broadcast_to battle, BattleSerializer.new(battle)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    
    battle = Battle.find(params['battle'])
    
    stream_for battle
    BattleChannel.broadcast_to battle, 'DONE'
  end
end
