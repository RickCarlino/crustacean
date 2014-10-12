require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  def test_create_review_for_many
    user = create(:user)
    topic
    ans  = Answer.joins(:question).find_by(questions: {name: '한글'})
    old_count = Review.count
    result = ans.create_review_for(user, @topic)
    # There should be 2 new reviews if the question reviews against 2 other q's
    new_count = ans.question.review_against.count + old_count
    assert_equal new_count, Review.count,
      'didnt make reviews for each of the review_against questions'
  end

  def test_create_review_for_nil
    user = create(:user)
    topic
    ans  = Answer.joins(:question).find_by(questions: {name: '품사'})
    old_count = Review.count
    result = ans.create_review_for(user, @topic)
    # This question should not create any new reviews.
    assert_equal old_count, Review.count,
      'expected no new reviews to be created since review_against == []'
  end

end
