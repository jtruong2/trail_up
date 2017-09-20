FactoryGirl.define do
  factory :comment do
    body "MyText"
    star_rating 1
    trail nil
    user nil
  end
end
