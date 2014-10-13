FactoryGirl.define do
  factory :question do
    topic
    name { Faker::Hacker.noun }
  end
end
