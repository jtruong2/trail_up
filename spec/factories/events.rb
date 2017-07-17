FactoryGirl.define do
  factory :event do
    trail
    name {generate(:event_name)}
    description "Event Description"
    date "07-07-2017 18:57:17"
    archived false

    factory :event_with_host do

      after(:create) do |event|
        create(:event_role, event: event, role: 1)
      end
    end
  end

  sequence :event_name do |n|
    "Event #{n}"
  end

end
