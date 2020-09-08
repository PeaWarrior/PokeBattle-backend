class TeamPokemonsController < ApplicationController

    def create
        team = @current_user.teams.find(team_pokemon_params[:team_id])
        if team && team.team_pokemons.length < 3
            team_pokemon = team.team_pokemons.create(team_pokemon_params)
            team_pokemon.update(shiny: true) if shiny_generator()
            team_pokemon.getMoves()
            render json: { team_pokemon: TeamPokemonSerializer.new(team_pokemon) }, include: '**'
        else
            render json: { error: "Unable to add pokemon to team" }, status: :unauthorized
        end
    end

    def delete
        team_pokemon = @current_user.team_pokemons.find(params[:id])
        if team_pokemon
            team = Team.find(team_pokemon.team_id)
            team_pokemon.destroy()
            render json: { team: TeamSerializer.new(team), message: "#{team_pokemon.nickname} was released back into the wild!" }
        else
            render json: { error: "Unable to release pokemon" }, status: :unauthorized
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