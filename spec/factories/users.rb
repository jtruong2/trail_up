FactoryGirl.define do
  factory :user do
    username 
    email
    password "password"


    factory :user_with_attending_events do
      transient do
        event_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:event_role, evaluator.event_count, user: user )
      end
    end

    factory :user_with_hosted_events do
      transient do
        event_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:event_role, evaluator.event_count, user: user, role: 1)
      end
    end
  end

  sequence :username do |i|
    "Tom Orlo #{i}"
  end

  sequence :email do |i|
    "tomorlo@gmail.com #{i}"
  end

end
