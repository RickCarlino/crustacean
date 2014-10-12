# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do

    trait :chickens do
      after(:create) do |topic|
        breed = create(:question, name: "breed",
                                  topic: topic,
                                  review_strategy: 'all')
        comb  = create(:question, name: "comb",
                                  topic: topic,
                                  review_strategy: 'none')
        type  = create(:question, name: "type",
                                  topic: topic,
                                  review_strategy: 'none')
        broodiness = create(:question, name: "broodiness",
                                       topic: topic,
                                       review_strategy: 'none')

        yokohama = create(:fact, topic: topic)

        create(:answer, question: breed, data: 'Yokohama', fact: yokohama)
        create(:answer, question: comb, data: 'walnut', fact: yokohama)
        create(:answer, question: type, data: 'light breed', fact: yokohama)
        create(:answer, question: type, data: 'softfeather', fact: yokohama)
        create(:answer, question: broodiness, data: 'rarely', fact: yokohama)
      end
    end

    trait :pokemon do
      after :create do |topic|
        pokedex = create(:question, name: "pokedex", topic: topic)
        name  = create(:question, name: "name", topic: topic)
        type  = create(:question, name: "type", topic: topic)

        bulbasaur = create(:fact, topic: topic)

        create(:answer, question: pokedex, data: '001', fact: bulbasaur)
        create(:answer, question: name, data: 'Bulbasaur', fact: bulbasaur)
        create(:answer, question: type, data: 'grass', fact: bulbasaur)
        create(:answer, question: type, data: 'poison', fact: bulbasaur)
      end
    end
  end
end
