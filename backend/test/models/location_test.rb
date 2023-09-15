require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  test "can initialize location" do
    location = Location.new
    location.assign_attributes(name: 'New York, New York', lat: 40.7128, lon: -74.0060)

    assert_instance_of Location, location
    assert_equal 'New York, New York', location.name
    assert_equal 40.7128, location.lat
    assert_equal -74.0060, location.lon
  end

  test "get location by id" do
    Location.lookup_by_city_state('Boston, Massachusetts')
    location = Location.find_by(location_id: 'boston')
    assert_equal 'Boston, Massachusetts', location.name
  end

  test "can lookup location by coordinates" do
    location = Location.lookup_by_coordinates(lat: 42.2793, lon: -71.4162)
    assert_match /^framingham/, location.location_id
  end

  test "location lookup return city and state" do
    location = Location.lookup_by_coordinates(lat: 42.2793, lon: -71.4162)
    assert_equal 'Framingham, Massachusetts', location.name
  end

  test "lookup returns nil for invalid coordinates" do
    assert_nil Location.lookup_by_coordinates(lat: nil, lon: nil)
  end

  test "generate_location_id generates location_id from name" do
    location = Location.new
    location.assign_attributes(name: 'New York, New York', lat: 40.7128, lon: -74.0060)

    location.send(:generate_location_id)
    assert_equal 'new_york', location.location_id
  end

  test "generate_location_id handles names with spaces and commas" do
    location = Location.new
    location.assign_attributes(name: 'New York, New York', lat: 40.7128, lon: -74.0060)

    location.send(:generate_location_id)
    assert_equal 'new_york', location.location_id
  end

  test "generate_location_id does not overwrite existing location_id" do
    location = Location.new
    location.assign_attributes(location_id: 'nueva_york', name: 'New York, New York', lat: 40.7128, lon: -74.0060)

    location.send(:generate_location_id)
    assert_equal 'nueva_york', location.location_id
  end
end
