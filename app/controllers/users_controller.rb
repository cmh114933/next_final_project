class UsersController < ApplicationController

	def create
		@user = User.last.id
		redirect_to "/users/#{@user}"
	end

  def show
  end
end
