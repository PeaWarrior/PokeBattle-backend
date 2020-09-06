class TeamsController < ApplicationController
    
    def index
        teams = @current_user.teams
        render json: teams, each_serializer: TeamSerializer, include: '**'
    end

    def create
        team = @current_user.teams.create(team_params)
        render json: team
    end

    def delete
        team = @current_user.teams.find(params[:id])
        team.destroy()
        render json: { message: "#{team.name} was succesfully deleted." }
    end

    private
    def team_params
        params.require(:team).permit(:id, :name)
    end

end