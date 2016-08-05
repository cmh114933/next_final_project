class Player < ActiveRecord::Base
	belongs_to :users
	belongs_to :game
	has_many :owned_stocks
end
