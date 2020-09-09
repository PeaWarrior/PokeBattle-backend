class User < ApplicationRecord
    has_many :teams, dependent: :destroy
    has_many :team_pokemons, through: :teams
    
    has_many :user_battles, dependent: :destroy
    has_many :battles, through: :user_battles

    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }, presence: true, length: {minimum: 3}
end
