
FactoryGirl.define do
  factory :user do
    name "Goonbag McDouchepants"
    sequence(:email) { |i| "goonbag#{i}@example.com"}
    global_admin false
    
    factory :user_admin do
      global_admin true
    end
  end
end
