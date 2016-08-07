class GamesController < ApplicationController

	def create
		@game=Game.create(current_player_id:)
	end

	def show

	end
end
