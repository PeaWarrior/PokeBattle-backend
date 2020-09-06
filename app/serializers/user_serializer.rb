class UserSerializer < ActiveModel::Serializer
  attributes :username, :activeTeam
  has_many :teams
end
