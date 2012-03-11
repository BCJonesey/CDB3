FactoryGirl.define do
  factory :event do
    site "your mom"
    start_date DateTime.now + 1.days
    end_date DateTime.now + 3.days
  end
end