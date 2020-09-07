class TeamPokemonSerializer < ActiveModel::Serializer
    attributes :id, :nickname, :shiny
    has_many :moves
    has_one :pokemon
end