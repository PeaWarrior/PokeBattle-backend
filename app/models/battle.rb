class Battle < ApplicationRecord
    has_many :user_battles, dependent: :destroy
    has_many :users, through: :user_battles

    validates_length_of :user_battles, maximum: 2

    def red_team=(team)
        team_pokemons = team.team_pokemons
        super({
            user_id: team.user_id,
            team_id: team.id,
            pokemons: get_team_pokemon(team_pokemons)
        })
    end

    def blue_team=(team)
        team_pokemons = team.team_pokemons
        super({
            user_id: team.user.id,
            team_id: team.id,
            pokemons: get_team_pokemon(team_pokemons)
        })
    end

    def get_team_pokemon(team_pokemons)
        team_pokemons.map do |team_pokemon|
            {
                name: team_pokemon.nickname,
                shiny: team_pokemon.shiny,
                types: team_pokemon.pokemon.types,
                sprites: team_pokemon.pokemon.sprites,
                stats: team_pokemon.pokemon.stats,
                moves: team_pokemon.moves
            }
        end
    end

    def modifierMessage(modifier)
        case modifier
        when 0.5
            'It was not very effective...'
        when 2
            'It was super effective!'
        else
            return
        end
    end

    def takeHit(damage, modifier, move_index)
        current_turn = self.turn.to_i
        current_team = (current_turn == self.red_team['user_id'] ? 'red' : 'blue')
        red_active_pokemon = red_team['pokemons'][red_active]
        blue_active_pokemon = blue_team['pokemons'][blue_active]

        case current_team
        when 'red'
            move = red_active_pokemon['moves'][move_index]
            blue_active_pokemon['stats']['hp'] -= damage
            self.message = "#{red_active_pokemon['name']} used #{move['name']}! #{modifierMessage(modifier)}"

            if (blue_active_pokemon['stats']['hp'] <= 0)
                blue_active_pokemon['stats']['hp'] = 0
                self.blue_active += 1
                if (self.blue_active > self.blue_team['pokemons'].length-1)
                    self.status = "closed"
                    self.winner = self.users[0].id
                    winning_team = Team.find(self.red_team['team_id'])
                    winning_team.update(matches: (winning_team.matches+1), wins: (winning_team.wins+1))

                    losing_team = Team.find(self.blue_team['team_id'])
                    losing_team.update(matches: (losing_team.matches+1), losses: (losing_team.losses+1))
                else
                end
            end
            self.turn = blue_team['user_id']
        when 'blue'
            move = blue_active_pokemon['moves'][move_index]
            red_active_pokemon['stats']['hp'] -= damage
            self.message = "#{blue_active_pokemon['name']} used #{move['name']}! #{modifierMessage(modifier)}"

            if (red_active_pokemon['stats']['hp'] <= 0) 
                red_active_pokemon['stats']['hp'] = 0
                self.red_active += 1

                if (self.red_active >= self.red_team['pokemons'].length-1)
                    self.status = "closed"
                    self.winner = self.users[1].id
                    winning_team = Team.find(self.blue_team['team_id'])
                    winning_team.update(matches: (winning_team.matches+1), wins: (winning_team.wins+1))

                    losing_team = Team.find(self.red_team['team_id'])
                    losing_team.update(matches: (losing_team.matches+1), losses: (losing_team.losses+1))
                else
                end
            end
            self.turn = red_team['user_id']
        end
        self.save()
    end

    def calculateDamage(move_index)
        current_turn = self.turn.to_i
        current_team = (current_turn == self.red_team['user_id'] ? 'red' : 'blue')
        red_active_pokemon = red_team['pokemons'][red_active]
        blue_active_pokemon = blue_team['pokemons'][blue_active]
        case current_team
        when 'red'
            attack = red_active_pokemon['moves'][move_index]
            calculate(red_active_pokemon, blue_active_pokemon, attack)
        when 'blue'
            attack = blue_active_pokemon['moves'][move_index]
            calculate(blue_active_pokemon, red_active_pokemon, attack)
        end
        
    end

    def calculate(attacker, defender, move)
        move_type = move['types']
        move_damage_type = move['damage']
        move_power = move['power']

        attacker_stats = attacker['stats']
        defender_stats = defender['stats']
        defender_types = defender['types']
        
        case move_damage_type
        when 'physical'
            raw_damage = ((move_power * attacker_stats['attack']/defender_stats['defense'])/5) * get_modifier(move_type, defender_types)
            return [raw_damage, get_modifier(move_type, defender_types)]
        when 'special'
            raw_damage = ((move_power * attacker_stats['spAttack']/defender_stats['spDefense'])/5) * get_modifier(move_type, defender_types)
            return [raw_damage, get_modifier(move_type, defender_types), move]
        end
    end

    def get_modifier(move_type, defender_types)
    
        modifier = 1

        defender_types.each do |defender_type|
            case move_type
            when 'bug'
                modifier *= bug_modifier(defender_type)
            when 'dragon'
                modifier *= dragon_modifier(defender_type)
            when 'electric'
                modifier *= electric_modifier(defender_type)
            when 'fighting'
                modifier *= fighting_modifier(defender_type)
            when 'fire'
                modifier *= fire_modifier(defender_type)
            when 'flying'
                modifier *= flying_modifier(defender_type)
            when 'ghost'
                modifier *= ghost_modifier(defender_type)
            when 'grass'
                modifier *= grass_modifier(defender_type)
            when 'ground'
                modifier *= ground_modifier(defender_type)
            when 'ice'
                modifier *= ice_modifier(defender_type)
            when 'normal'
                modifier *= normal_modifier(defender_type)
            when 'poison'
                modifier *= poison_modifier(defender_type)
            when 'psychic'
                modifier *= psychic_modifier(defender_type)
            when 'rock'
                modifier *= rock_modifier(defender_type)
            when 'water'
                modifier *= water_modifier(defender_type)
            end
        end
        modifier
    end

    def bug_modifier(defender_type)
        debugger
        case defender_type
        when 'grass', 'psychic', 'poison'
            return 2
        when 'fighting', 'flying', 'ghost', 'fire'
            return 0.5
        else
            return 1
        end
    end

    def dragon_modifier(defender_type)
        case defender_type
        when 'dragon'
            return 2
        else
            return 1
        end
    end

    def electric_modifier(defender_type)
        case defender_type
        when 'flying', 'water'
            return 2
        when 'grass', 'electric', 'dragon'
            return 0.5
        when 'ground'
            return 0
        else
            return 1
        end
    end

    def fighting_modifier(defender_type)
        case defender_type
        when 'normal', 'rock', 'ice'
            return 2
        when 'flying', 'poison', 'bug', 'psychic'
            return 0.5
        when 'ghost'
            return 0
        else
            return 1
        end
    end

    def fire_modifier(defender_type)
        case defender_type
        when 'bug', 'grass', 'ice'
            return 2
        when 'rock', 'fire', 'water', 'dragon'
            return 0.5
        else
            return 1
        end
    end

    def flying_modifier(defender_type)
        case defender_type
        when 'fight', 'bug', 'grass'
            return 2
        when 'rock', 'electric'
            return 0.5
        else
            return 1
        end
    end

    def ghost_modifier(defender_type)
        case defender_type
        when 'ghost'
            return 2
        when 'normal', 'psychic'
            return 0
        else
            return 1
        end
    end

    def grass_modifier(defender_type)
        case defender_type
        when 'ground', 'rock', 'water'
            return 2
        when 'flying', 'poison', 'bug', 'fire', 'grass', 'dragon'
            return 0.5
        else
            return 1
        end
    end

    def ground_modifier(defender_type)
        case defender_type
        when 'poison', 'rock', 'fire', 'electric'
            return 2
        when 'bug', 'grass'
            return 0.5
        when 'flying'
            return 0
        else
            return 1
        end
    end

    def ice_modifier(defender_type)
        case defender_type
        when 'flying', 'ground', 'grass', 'dragon'
            return 2
        when 'water', 'ice'
            return 0.5
        else
            return 1
        end
    end

    def normal_modifier(defender_type)
        case defender_type
        when 'rock'
            return 0.5
        when 'ghost'
            return 0
        else
            return 1
        end
    end

    def poison_modifier(defender_type)
        case defender_type
        when 'bug', 'grass'
            return 2
        when 'poison', 'ground', 'rock', 'ghost'
            return 0.5
        else
            return 1
        end
    end

    def psychic_modifier(defender_type)
        case defender_type
        when 'fight', 'poison'
            return 2
        when 'psychic'
            return 0.5
        else
            return 1
        end
    end

    def rock_modifier(defender_type)
        case defender_type
        when 'flying', 'bug', 'fire', 'ice'
            return 2
        when 'fighting', 'ground'
            return 0.5
        else
            return 1
        end
    end

    def water_modifier(defender_type)
        case defender_type
        when 'ground', 'rock', 'fire'
            return 2
        when 'water', 'grass', 'dragon'
            return 0.5
        else
            return 1
        end
    end

end
