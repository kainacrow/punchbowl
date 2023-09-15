require 'test_helper'

class UserFavoriteTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    @location = create(:location)
    @user_favorite = create(:user_favorite, location: @location, user: @user)
  end

  test "should be valid" do
    assert @user_favorite.valid?
  end

  test "should require a user" do
    @user_favorite.user = nil
    assert_not @user_favorite.valid?
  end

  test "should require a location" do
    @user_favorite.location = nil
    assert_not @user_favorite.valid?
  end

  test "location_id should match location's location_id" do
    assert_equal @user_favorite.location_id, @user_favorite.location.location_id
  end
end
