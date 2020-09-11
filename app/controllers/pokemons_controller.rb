class PokemonsController < ApplicationController
    skip_before_action :authenticate, only: [:index]

    def index
        pokemons = Pokemon.all
        render json: pokemons
    end

    def show
        pokemon = Pokemon.find(params[:id])
        render json: pokemon.sprites
    end

end