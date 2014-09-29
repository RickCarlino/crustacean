require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  test '#populate_reviews' do
    answer = topic.questions.first.answers.first
    user      = FactoryGirl.create(:user)
    answer.populate_reviews(user)
    question_names = Review.all.map(&:question).map(&:name).sort

    assert_equal question_names, ["broodiness", "comb", "type"]
    assert_equal Review.count, 3
  end
end
