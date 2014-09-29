# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    trait :chickens do
      after(:create) do |topic|
        breed = create(:question, name: "breed", topic: topic)
        comb  = create(:question, name: "comb", topic: topic)
        type  = create(:question, name: "type", topic: topic)
        broodiness = create(:question, name: "broodiness", topic: topic)

        yokohama = create(:fact, topic: topic)

        create(:answer, question: breed, data: 'Yokohama', fact: yokohama)
        create(:answer, question: comb, data: 'walnut', fact: yokohama)
        create(:answer, question: type, data: 'light breed', fact: yokohama)
        create(:answer, question: type, data: 'softfeather', fact: yokohama)
        create(:answer, question: broodiness, data: 'rarely', fact: yokohama)
      end
    end
  end
end
