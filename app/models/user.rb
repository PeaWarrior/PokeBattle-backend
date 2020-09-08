class User < ApplicationRecord
    has_many :teams, dependent: :destroy
    has_many :team_pokemons, through: :teams

    has_secure_password
    validates :username, uniqueness: { case_sensitive: false }
end
