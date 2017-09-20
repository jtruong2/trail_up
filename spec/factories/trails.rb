FactoryGirl.define do
  factory :trail do
    name { generate(:trail_name) }
    description { generate(:description) }
    difficulty
    distance 30.0
    rating 5.0
    longitude 30.000
    latitude -100.000
    location "Boulder, CO"
  end

  sequence :trail_name do |n|
    "Trail #{n}"
  end

  sequence :description do |n|
    "Description #{n}"
  end

end
