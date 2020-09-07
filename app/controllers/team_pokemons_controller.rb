class TeamPokemonsController < ApplicationController

    def create
        team = @current_user.teams.find(team_pokemon_params[:team_id])
        if team 
            team_pokemon = team.team_pokemons.create(team_pokemon_params)
            render json: { team_pokemon: TeamPokemonSerializer.new(team_pokemon) }, include: '**'
        else
            render json: { error: "Unable to create pokemon" }, status: :unauthorized
        end
    end

    private

    def team_pokemon_params
        params.require(:team_pokemon).permit(:nickname, :pokemon_id, :team_id)
    end

end