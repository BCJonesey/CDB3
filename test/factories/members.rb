FactoryBot.define do
  factory :member do
    association :game, factory: :game_the_calling
    association :user
  end
end