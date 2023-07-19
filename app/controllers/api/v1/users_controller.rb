class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      token = encoded_token({ user_id: @user.id })

      render json: { user: @user, token: token }, status: :ok
    else
      render json: {error: 'Failed to create user!'}, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
