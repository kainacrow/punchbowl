class Location < ActiveRecord::Base
  before_create :generate_location_id

  validates :location_id, presence: true
  validates :name, presence: true
  validates :lat, presence: true
  validates :lon, presence: true

  has_many :user_favorites
  has_many :favorited_by, through: :user_favorites, source: :user

  private
  def generate_location_id
    self.location_id ||= name.downcase.gsub(' ', '_').split(',').first
  end

  def self.lookup_by_coordinates(lat:, lon:)
    location = find_or_initialize_by(lat: lat, lon: lon)

    if location.new_record?
      city = Geocoder.search([lat, lon]).first.city
      state = Geocoder.search([lat, lon]).first.state
      location.name = city + ', ' + state
      location.send(:generate_location_id)
    end

    location.save
    location
  rescue
    nil
  end

  def self.lookup_by_city_state(city_state)
    location = find_or_initialize_by(name: city_state)
    if location.new_record?
      city = Geocoder.search(city_state).first.city
      state = Geocoder.search(city_state).first.state
      lat = Geocoder.search(city_state).first.coordinates[0]
      lon = Geocoder.search(city_state).first.coordinates[1]
      location.name = city + ', ' + state
      location.lat = lat
      location.lon = lon
      location.send(:generate_location_id)
    end

    location.save
    location
  rescue
    nil
  end
end
