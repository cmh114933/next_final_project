class Game < ActiveRecord::Base
	has_many :players
	has_many :users, through: :players
	has_many :stocks

	def dice_roll
		rand(1..6)
	end

	def method_name
		
	end
end
