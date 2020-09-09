class UserBattle < ApplicationRecord
  belongs_to :user
  belongs_to :battle
end
