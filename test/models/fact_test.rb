require 'test_helper'

class FactTest < ActiveSupport::TestCase
  def fact
    topic.facts.first
  end

  test '#populate_reviews' do
    fact.populate_reviews(User.create)
    m = Review.all.map{|r| { r.answer.data => r.question.answers.map(&:data) } }
    assert_equal 7, Review.count,
      'Incorrect number of reviws created. Be mindful of \`special\` questions'
    assert_equal [1], Review.all.pluck(:fact_id).uniq,
      '#populate_reviews() should only populate reviews for one fact'
  end
end
