# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :topic do
    name { Faker::Hacker.ingverb }
    after(:create) do |top|
      ques  = create_list(:question, 4, topic: top)
      facts = create_list(:fact, 4, topic: top)
      ques.each do |question|
        question.update_attributes(counter_questions: (ques - [question]))
        2.times { create(:answer, question: question, fact: facts.sample) }
      end
    end
  end

  factory :korean_topic, class: Topic do
    after(:create) do |tpc|
      tpc.update_attributes(name: '한국어')

      한글 = create(:question, name: '한글', topic: tpc)
      영어 = create(:question, name: '영어', topic: tpc)
      품사 = create(:question, name: '품사', topic: tpc)
      발음 = create(:question, name: '발음', topic: tpc)

      한글.update_attributes(counter_questions: [영어, 품사])
      영어.update_attributes(counter_questions: [한글, 품사, 발음])
      품사.update_attributes(counter_questions: [])
      발음.update_attributes(counter_questions: [영어, 품사])

      호박 = Fact.create(topic: tpc)

      Answer.create(data: '호박',     question: 한글, fact: 호박)
      Answer.create(data: 'pumpkin', question: 영어, fact: 호박)
      Answer.create(data: '명사',     question: 품사, fact: 호박)
      Answer.create(data: '호박.mp3', question: 발음, fact: 호박)

    end
  end
end
