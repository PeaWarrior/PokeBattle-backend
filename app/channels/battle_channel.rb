class BattleChannel < ApplicationCable::Channel

  def subscribed
    # stream_from "some_channel"
    user = User.find_by(username: params['username'])
    if user && params['matching']
      battle = Battle.last
      if !battle || battle.users.length === 2
        Battle.create(red_user_id: user.id, red_team: params['team']).users << user
        console.log(battle)
        # render it and also broadcast
      else
        battle.users << user
        battle.update(blue_user_id: user.id, blue_team: params['team'])
        console.log(battle)
      end
      # battle = Battle.last
      # battle.users.length < 2 ? battle
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
