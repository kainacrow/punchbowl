require 'test_helper'

class Api::UserFavoritesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @location = create(:location)

  end

  test "should get index" do
    get api_user_favorites_url, as: :json
    assert_response :success
  end

  test "should create user_favorite" do
    assert_difference('UserFavorite.count') do
      post api_user_favorites_url, params: { location_id: @location.location_id }, as: :json
    end

    assert_response 201
  end

  test "should not create invalid user_favorite" do
    assert_no_difference('UserFavorite.count') do
      post api_user_favorites_url, params: { location_id: nil }, as: :json
    end

    assert_response :unprocessable_entity
  end

  test "should destroy user_favorite" do
    user_favorite = create(:user_favorite, location: @location, user: @user)
    assert_difference('UserFavorite.count', -1) do
      delete api_user_favorite_url(user_favorite.location_id), as: :json
    end

    assert_response :no_content
  end
end
