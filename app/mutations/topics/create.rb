module Topics
  class Create < Mutations::Command
    attr_accessor :topic

    required do
      string :name
      hash   :questions do
        array :*, arrayize: true
      end
    end

    def validate
    end

    def execute
      # TODO wrap this in a transaction. Seriously.
      @topic = Topic.create
      question_map.map do |ques, counter|
        binding.pry
        ques.counter_questions = counter
      end
      @topic
    end

private

  # Takes a Hash<String:String[]> and turns it into a Hash<Question:Question[]>
  # Used as an intermediate step for linking questions to a group of counter questions.
  def question_map
    # TODO get fancy with inject or sth.
    question_map = {}
    questions.map do |key, value|
      list = make_questions(value)
      question_map[Question.find_or_create_by(topic: topic, name: name)] = list
    end
    question_map
  end

  def make_questions(arry)
    arry.map { |name| make_question(name) }
  end

  def make_question(name)
    Question.find_or_create_by(topic: topic, name: name)
  end

  end
end