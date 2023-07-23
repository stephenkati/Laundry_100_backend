class Api::V1::UsersController < ApplicationController
  def create
    @user = User.new(user_params)

    if @user.save
      token = encoded_token({ user_id: @user.id })

      render json: { user: @user, token: }, status: :ok
    else
      render json: { error: 'Failed to create user!' }, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(email: login_params[:email])

    if @user && @user.authenticate(login_params[:password])
      token = encoded_token({ user_id: @user.id })

      render json: { user: @user, token: }, status: :ok
    else
      render json: { error: 'Failed to Log In user!' }, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.require(:loginDetails).permit(:email, :password)
  end

  def user_params
    params.require(:registrationDetails).permit(:name, :email, :password)
  end
end
