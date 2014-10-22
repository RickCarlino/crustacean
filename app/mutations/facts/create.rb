module Facts
  class Create < Mutations::Command
    required do
      model :topic
      model :user
      hash :answers do
        array :*, class: String, arrayize: true, nils: false
      end
    end

    def execute
      validate_answers
      create_fact
    end

private

    def create_fact
      ActiveRecord::Base.transaction do
        @fact = Fact.create(topic: topic)
        answers.each { |key, val| create_answer(key, val) }
      end
    end

    def create_answer(key, value)
      question = topic.questions.find_by(name: key)
      value.each do |data|
        Answer.create(question: question, fact: @fact, data: data)
      end
    end

#====

    def validate_answers
      answers.each { |key, value| validate_answer(key, value) }
    end

    def validate_answer(key, value)
      unless question_names.include?(key)
        add_error :answers,
          :invalid_question,
          "#{key} is not a valid question name. Try these: #{question_names}"
      end
    end

    def question_names
      topic.questions.pluck(:name)
    end
  end
end