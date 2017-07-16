FactoryGirl.define do
  factory :event do
    trail
    name {generate(:event_name)}
    description "Event Description"
    date "07-07-2017 18:57:17"
  end

  sequence :event_name do |n|
    "Event #{n}"
  end

end
