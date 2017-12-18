FactoryBot.define do
  factory :currency do
    sequence(:name) { |i| "Currency Name #{i}"}
    sequence(:short_name) { |i| "CP#{i}"}
    association :game, factory: :game_the_calling
  end
end
