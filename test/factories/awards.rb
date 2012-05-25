# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :award do
    
    comment "MyText"
    amount "9.99"
    
    
    association :approved_by, factory: :member
    association :created_by, factory: :member
    association :currency
    association :character
  end
end
