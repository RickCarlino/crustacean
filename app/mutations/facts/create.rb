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
        @fact = Fact.new
        binding.pry
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