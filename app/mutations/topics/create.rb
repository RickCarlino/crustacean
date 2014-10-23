module Topics
  class Create < Mutations::Command
    required do
      string :name
      hash   :questions do
        array :*, arrayize: true
      end
    end

    def validate
      sanitize_questions
      validate_questions
    end

    def execute
      ActiveRecord::Base.transaction do
        @topic = Topic.create(name: name)
        question_map.each { |k, v| create_question(k, v) }
      end
      @topic
    end

private
    # A written appology from Rick Carlino, author of this method:
    # I'm so sorry. The input comes in as strings mapped to strings. I need
    # AR objects mapped to a collection of AR objects. It's the best I could do.
    def question_map
      @question_map ||= questions.inject({}) do |h,(k,str)|
        k      = Question.find_or_create_by(topic: @topic, name: k)
        h[k]   = str.uniq.map{ |nm|
          Question.find_or_create_by(topic: @topic, name: nm) }
        h
      end
    end

    def create_question(k, v)
      k.update_attributes(review_against: v)
    end

    def sanitize_questions
      @question_names = questions.keys
      questions.each{|k,v| v.uniq!}
    end

    def validate_questions
      questions.each do |k,v|
        unless ( v - (questions.keys - [k]) ).empty?
          add_error :questions, :invalid, "You attempted to review a question "\
            "against an invalid counter question. You entered:[#{v.join(',')}]"\
            " You can only use the following:[#{questions.keys.join(',')}]"
        end
      end
    end
  end
end