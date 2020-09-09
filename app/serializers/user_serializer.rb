class UserSerializer < ActiveModel::Serializer
  attributes :username, :active
  has_many :teams
end
