class GamesController < ApplicationController
	skip_before_action :verify_authenticity_token, only: [:create]

	def create


		if Game.where(status: "PENDING").empty?
			@game=Game.create(status: "PENDING")
		else
			@game=Game.find_by_status("PENDING")
		end		
		@player = Player.create(user_id: current_user.id, game_id: @game.id)
		@game.update(status:"READY")if Player.where(game_id:@game.id).count == 3
		render json: { game_id: @game.id}
	end

	def show
		@game = Game.find(params[:id])
		gon.publish_key = ENV['PUBNUB_PUBLISH_KEY']
		gon.subscribe_key = ENV['PUBNUB_SUBSCRIBE_KEY']
		gon.user_email = current_user.email
		gon.game_id=@game.id
	end

	def game_id
		@game = Game.find(params[:id])
		respond_to do |format|
	        format.js
	    end
	end
end
