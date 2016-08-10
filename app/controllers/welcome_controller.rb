class WelcomeController < ApplicationController
  def index
  	if signed_in? 

		gon.publish_key = ENV['PUBNUB_PUBLISH_KEY']
		gon.subscribe_key = ENV['PUBNUB_SUBSCRIBE_KEY']
		gon.user_email = current_user.email
	end
  end
end
