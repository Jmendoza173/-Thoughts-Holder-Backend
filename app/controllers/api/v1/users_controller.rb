class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show,:update,:destroy]

  def index
      users = User.all
      render json: users, status: 200
  end

  def create
    user = User.create(user_params)
    if user.valid?
      render json: authentication_json(user.id)
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    user_id = params[:id]
    if logged_in_user_id == user_id.to_i
      @user.update(user_params)
      render json: @user, status: 200
    else
      render json: { go_away: true }, status: :unauthorized
    end
  end

  def destroy
    user_id = params[:id]
    if logged_in_user_id == user_id.to_i
      userId = @user.id
      @user.destroy
      render json: {message:"Zap! user deleted", userId:userId}
    else
      render json: { go_away: true }, status: :unauthorized
    end
  end

  def show
    user_id = params[:id]
    if logged_in_user_id == user_id.to_i
      render json: @user, status: 200
    else
      render json: { go_away: true }, status: :unauthorized
    end
  end

  private
  def user_params
    params.permit(:username, :password, :firstName, :lastName, :email)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
