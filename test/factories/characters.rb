 FactoryGirl.define do
  factory :character do
   association :character_version
   association :member
   name "Yam Bag the III"
  end
end