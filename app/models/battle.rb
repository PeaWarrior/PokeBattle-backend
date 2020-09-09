class Battle < ApplicationRecord
    has_many :user_battles, dependent: :destroy
    has_many :users, through: :user_battles

    validates_length_of :user_battles, maximum: 2

    def red_team=(team)
        team_pokemons = team.team_pokemons
        super({
            team_name: team.name,
            pokemons: get_team_pokemons(team_pokemons)
        })
    end

    def blue_team=(team)
        team_pokemons = team.team_pokemons
        super({
            team_name: team.name,
            pokemons: get_team_pokemons(team_pokemons)
        })
    end

    def get_team_pokemons(team_pokemons)
        team_pokemons.map do |team_pokemon|
            {
                pokemon_id: team_pokemon.pokemon.id,
                nickname: team_pokemon.nickname,
                shiny: team_pokemon.shiny,
                hp: team_pokemon.pokemon.stats['hp']
            }
        end
    end

end
