class TeamSerializer < ActiveModel::Serializer
    attributes :id, :name, :matches, :wins, :losses
    has_many :team_pokemons
  end
  