class BattlesController < ApplicationController
    after_action :broadcast_join, only: :join

    def index
        battles = Battle.where(status: ['open', 'full'])
        if battles 
            render json: battles
        else
            render json: { message: 'There are currently no open battles' }
        end
    end

    def show
        battle = @current_user.battles.last
        render json: battle
    end

    def create
        if @current_user.teams.length > 0
            team = @current_user.teams[battle_params[:team_index].to_i]
            room_name = battle_params[:room_name].length > 0 ? battle_params[:room_name] : "Room ##{rand(1000...9999)}"
            formatted_params = {
                room_name: room_name,
                red_team: team,
                status: 'open',
                red_active: 0
            }
            battle = Battle.create(formatted_params)
            battle.users << @current_user
            if battle.valid?
                ActionCable.server.broadcast 'open_battles', BattleSerializer.new(battle)
                render json: battle
            else
                render json: { error: 'Could not create battle room' }, status: :bad_request
            end
        else
            render json: { error: 'You must have a team before battling' }, status: :bad_request
        end

    end

    def join
        if @current_user.teams.length > 0
            team = @current_user.teams[battle_params[:team_index].to_i]
            battle = Battle.find(battle_params[:id])
            if battle
                formatted_params = {
                    blue_team: team,
                    status: 'full',
                    blue_active: 0
                }
                battle.update(formatted_params)
                battle.users << @current_user
                turn = battle.blue_team['pokemons'][0]['stats']['speed'] > battle.red_team['pokemons'][0]['stats']['speed'] ? battle.users[1].id : battle.users[0].id
                battle.update(turn: turn)
                render json: battle
            else 
                render json: { error: 'Could not join battle room' }, status: :bad_request
            end
        else
            render json: { error: 'You must have a team before battling' }, status: :bad_request
        end
    end

    def fight
        battle = @current_user.battles.find(battle_params[:id])
        damage = battle.calculateDamage(battle_params[:move_index])[0]
        modifier = battle.calculateDamage(battle_params[:move_index])[1]
        battle.takeHit(damage, modifier, battle_params[:move_index])
        BattleChannel.broadcast_to battle, BattleSerializer.new(battle)
        render json: battle
    end

    private

    def broadcast_join
        battle = Battle.find(battle_params[:id])
        # BattleChannel.broadcast_to battle, BattleSerializer.new(battle)
        ActionCable.server.broadcast 'open_battles', BattleSerializer.new(battle)
    end

    def battle_params
        params.require(:battle).permit(:team_index, :room_name, :id, :move_index)
    end

end