FactoryGirl.define do
  factory :currency do
    name "Goonbag McDouchepants"
    sequence(:short_name) { |i| "CP#{i}"}
    yearly_cap false
    association :game, factory: :game_the_calling
  end
end
