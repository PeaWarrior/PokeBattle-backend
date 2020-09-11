class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :active
  has_many :teams
end
