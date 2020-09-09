class UserChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    user = User.find_by(username: params[:username])
    user.update(active: true)
    stream_from 'online_list'
    ActionCable.server.broadcast 'online_list', UserSerializer.new(user)
  end

  def unsubscribed
    user = User.find_by(username: params[:username])
    user.update(active: false)
    stream_from 'online_list'
    ActionCable.server.broadcast 'online_list', UserSerializer.new(user)
    # Any cleanup needed when channel is unsubscribed
  end
end
