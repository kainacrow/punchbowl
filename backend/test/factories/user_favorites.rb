FactoryBot.define do
  factory :user_favorite do
    association :user
    association :location
  end
end
