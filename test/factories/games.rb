FactoryGirl.define do
  factory :game do
      sequence(:name){|i| "Game #{i}"}
      sequence(:slug){|i| "Game#{i}"}
    factory :game_mirror_mirror do
      name "Mirror Mirror"
    end
    factory :game_the_calling do
      name "The Calling"
    end
  end
end

