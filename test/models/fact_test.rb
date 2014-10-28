require 'test_helper'

class FactTest < ActiveSupport::TestCase
  def test_create_review_for_many
    # TODO this test is brittle and not comprehensive.
    user = create(:user)
    topic
    fct = Fact.last
    result    = fct.create_review_for(user)
    new_count = Review.count
    expected_count = Question.all.map(&:counter_questions).map(&:count).sum
    assert_equal expected_count, new_count,
      'expected reviews created to equal the sum of all counter_questions entries'\
      ' in the given topics questions (sorry)'
    assert_equal [fct.id], Review.all.pluck(:fact_id).uniq,
      'all reviews created should reference the current fact'
  end
end
