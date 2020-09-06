class TeamPokemonSerializer < ActiveModel::Serializer
    attributes :id, :nickname, :shiny
    has_one :pokemon
    # has_many :moves
end