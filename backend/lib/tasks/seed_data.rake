namespace :seed_data do
  desc 'Populate the locations table with static data'
  task locations: :environment do
    locations_data = [
                      { location_id: "new_york", name: 'New York, New York', lat: 40.7128, lon: -74.0060 },
                      { location_id: "boston", name: 'Boston, Massachusetts', lat: 42.3601, lon: -71.0589 },
                      { location_id: "chicago", name: 'Chicago, Illinois', lat: 41.8781, lon: -87.6298 },
                      { location_id: "denver", name: 'Denver, Colorado', lat: 39.7392, lon: -104.9903 },
                      { location_id: "houston", name: 'Houston, Texas', lat: 29.7604, lon: -95.3698 },
                      { location_id: "seattle", name: 'Seattle, Washington', lat: 47.6062, lon: -122.3321 },
                      { name: 'Los Angeles, California', lat: 34.0522, lon: -118.2437 }
                    ]

    locations_data.each do |data|
      location_id = data[:name].downcase.gsub(' ', '_').split(',').first

      next if Location.exists?(location_id: location_id)

      Location.create(location_id: location_id, **data)
    end
    puts 'Static data inserted into the locations table.'
  end

  desc 'Populate the users table'
  task users: :environment do
    User.create
  puts 'single user created'
  end

  desc 'Populate the favorite locations table'
  task user_favorites: :environment do
    UserFavorite.create(
      [
        {user: User.first, location: Location.first},
        {user: User.first, location: Location.second},
        {user: User.first, location: Location.third},
        {user: User.first, location: Location.fourth}
      ]
    )
  puts 'Saved favorite locations to user'
  end
end