require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  def test_counter_questions
    # TODO real tests.
    question = create(:question)
    assert question.counter_questions.length == 0,
      'Expected to have counter_questions'
  end
end
