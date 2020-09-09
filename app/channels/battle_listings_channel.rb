class BattleListingsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # battles = Battle.where(status: ["open"])
    battles = Battle.all

    stream_from 'open_battles'
    # ActionCable.server.broadcast 'open_battles', battles
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
