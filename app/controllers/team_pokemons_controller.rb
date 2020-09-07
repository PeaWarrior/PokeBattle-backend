class TeamPokemonsController < ApplicationController

    def create
        team = @current_user.teams.find(team_pokemon_params[:team_id])
        if team
            team_pokemon = team.team_pokemons.create(team_pokemon_params)
            team_pokemon.update(shiny: true) if shiny_generator()
            team_pokemon.getMoves()
            render json: { team_pokemon: TeamPokemonSerializer.new(team_pokemon) }, include: '**'
        else
            render json: { error: "Unable to create pokemon" }, status: :unauthorized
        end
    end

    private

    def team_pokemon_params
        params.require(:team_pokemon).permit(:nickname, :pokemon_id, :team_id)
    end

    def shiny_generator
        rand(1...17) === rand(1...17) ? true : false
    end

end