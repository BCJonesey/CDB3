# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :label do
    sequence(:name) { |i| "label #{i}"}
    association :game
  end
end
