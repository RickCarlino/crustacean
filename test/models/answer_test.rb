require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  def test_populate_one_review
    user = create(:user)
    topic
    ans  = Answer.last
    ans.create_review_for(user, @topic)
  end
end
