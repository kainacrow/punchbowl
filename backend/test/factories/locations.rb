FactoryBot.define do
  factory :location do
    name { 'New York, New York' }
    lat { 40.7128 }
    lon { -74.0060 }
    location_id { 'new_york' }
  end
end
