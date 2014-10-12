require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  def test_populate_one_review
    topic
    ans  = Answer.last
    user = create(:user)
  end
end
