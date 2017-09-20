FactoryGirl.define do
  factory :trail do
    name { generate(:trail_name) }
    description { generate(:description) }
    difficulty 
    distance 30.0
    rating 5.0
    latitude 40.13
    longitude -103.01
  end

  sequence :trail_name do |n|
    "Trail #{n}"
  end

  sequence :description do |n|
    "Description #{n}"
  end

end
