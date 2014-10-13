# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :answer do
    question
    fact
    data { Faker::Hacker.adjective }
  end
end
