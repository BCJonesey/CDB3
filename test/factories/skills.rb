FactoryGirl.define do
  factory :skill do
    sequence(:name) { |i| "pooping tier #{i}"}
    association :game
  end
end