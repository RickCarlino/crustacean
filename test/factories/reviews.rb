# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    question
    fact
    answer
    association :owner, factory: :user
  end
end
