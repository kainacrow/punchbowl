require 'test_helper'

class Api::WeathersControllerTest < ActionDispatch::IntegrationTest
  test 'get the weather returns json' do
    location = Location.create(name: 'Boston, Massachusetts', lat: 42.3601, lon: -71.0589)
    location.send(:generate_location_id)
    location.save
    get api_location_weather_path(location_id: location.location_id), as: :json
    assert_response :success

    assert response.parsed_body['current']
  end
end
