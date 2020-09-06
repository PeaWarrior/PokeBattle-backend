class PokemonSerializer < ActiveModel::Serializer
    attributes :id, :species, :sprites, :stats, :types, :moves
end