class TeamsController < ApplicationController
    
    def index
        teams = @current_user.teams
        render json: teams, each_serializer: TeamSerializer, include: '**'
    end

    def create
        team = @current_user.teams.create(team_params)
        if team.valid?
            render json: team
        else
            render json: { error: team.errors.full_messages }, status: :bad_request
        end
    end

    def delete
        team = @current_user.teams.find(params[:id])
        team.destroy()
        teams = @current_user.teams
        render json: teams, each_serializer: TeamSerializer, include: '**'
    end

    private
    def team_params
        params.require(:team).permit(:id, :name)
    end

end