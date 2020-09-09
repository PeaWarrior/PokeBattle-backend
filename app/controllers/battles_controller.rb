class BattlesController < ApplicationController

    def index
        battles = Battle.where(status: ['open'])
        if battles 
            render json: battles
        else
            render json: { message: 'There are currently no open battles' }
        end
    end

    def create
        if @current_user.teams.length > 0
            team = @current_user.teams[battle_params[:team_index]]
            room_name = battle_params[:room_name].length > 0 ? battle_params[:room_name] : "Room ##{rand(1000...9999)}"
            formatted_params = {
                room_name: room_name,
                red_user_id: @current_user.id,
                red_user_name: @current_user.username,
                red_team: team,
                status: 'open'
            }
            battle = Battle.create(formatted_params)
            battle.users << @current_user

            if battle.valid?
                ActionCable.server.broadcast 'open_battles', battle
                render json: battle
            else
                render json: { error: 'Could not create battle room' }, status: :bad_request
            end
        else
            render json: { error: 'You must have a team before battling' }, status: :bad_request
        end

    end

    private

    def battle_params
        params.require(:battle).permit(:team_index, :room_name)
    end

end