class UsersController < ApplicationController

	def create
		@user = User.last.id
		redirect_to "/users/#{@user}"
	end

  def show
  end

  private

	def user_params
    params.require(:user).permit(:username, :password, :token, :IGC_total, :IGC_base)
  end

end
