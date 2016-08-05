class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update]

	def create
		@user = User.last.id
		redirect_to "/users/#{@user}"
	end

  def show
  end

  def edit
  end

  def update
  	if @user.update(user_params)
  		redirect_to user_path
  	else
  		render 'edit'
  	end  
  end

  private

  def set_user
    @user = User.find(params[:id])
  end 

	def user_params
    params.require(:user).permit(:username, :password, :token, :IGC_total, :IGC_base, {avatars:[]})
  end

end
