class UsersController < ApplicationController

    def index
        pokemons = Pokemon.all
        render json: pokemons
    end

    def show
        pokemon = Pokemon.find(pokemon_params)
        render json: pokemon
    end

    private

    def pokemon_params
        params.require(:pokemon).permit(:id)
    end

end