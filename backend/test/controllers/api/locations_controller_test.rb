require 'test_helper'

class Api::LocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @location = create(:location)
  end

  test "should get index" do
    get api_locations_url, as: :json
    assert_response :success
  end

  test "should show location" do
    get api_location_url(@location.location_id), as: :json
    assert_response :success
  end

  test "should return not found for non-existent location" do
    get api_location_url('boston'), as: :json
    assert_response :not_found
    assert JSON.parse(response.body)['error'] == 'Location not found'
  end
end
