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
      @topic = Topic.new
    end

    def execute
      # TODO wrap this in a transaction. Seriously.
      hmm = question_map
      binding.pry
      @topic
    end

private

  def question_map
    # TODO get fancy with inject or sth.
    question_map = {}
    questions.map do |key, value|
      list = make_questions(value)
      question_map[Question.find_or_create_by(topic: topic, name: key)] = list
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