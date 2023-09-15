class Api::UserFavoritesController < ApplicationController

  def index
    @user_favorites = current_user.user_favorites
    render json: @user_favorites
  end

  def create
    @user_favorites = current_user.user_favorites.build(location_id: params[:location_id])
    if @user_favorites.save
      render json: @user_favorites, status: :created
    else
      render json: { errors: @user_favorites.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @user_favorites = current_user.user_favorites.find_by(location_id: params[:id])

    if @user_favorites
      @user_favorites.destroy
      head :no_content
    else
      render json: { error: "User favorite not found" }, status: :not_found
    end
  end

  def current_user
    User.first
  end
end
