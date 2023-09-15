class UserFavorite < ApplicationRecord
  belongs_to :user
  belongs_to :location, foreign_key: 'location_id', primary_key: 'location_id'
end
