class WeatherFetchJob < ApplicationJob
  queue_as :default

  def perform(location)
    client = OpenWeather::Client.new
    data = client.one_call(lat: location.lat, lon: location.lon, exclude: ['minutely', 'hourly', 'alerts'])
  rescue OpenWeather::Errors::Fault
    logger.error "Error accessing OpenWeather API"
  end
end
