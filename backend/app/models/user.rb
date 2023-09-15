class User < ApplicationRecord
  has_many :user_favorites
  has_many :favorites, through: :user_favorites, source: :location
end
