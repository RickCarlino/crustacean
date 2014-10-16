require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  def review
    @review ||= FactoryGirl.create(:review,
                                   last_review: time,
                                   next_review: time)
  end

  test 'mark_incorrect!' do
    time  = Time.now + 5.hours

    review.mark_incorrect!(time)

    last  = review.last_review.to_i
    _next = review.next_review.to_i

    assert_equal last, _next,
      'When incorrect, last_review and next_review should be equal'
    assert_equal 0, (last - _next),
      'Time difference should equal 0 when marked incorrect'
  end

  test 'mark_correct' do
    Timecop.freeze
    review_time = Time.now + 25.seconds
    review.mark_correct!(review_time)
    diff = (review.next_review.to_time - review.last_review.to_time).to_i
    assert_equal 120, diff,
      'expected a 25 second review gap to trigger a 2 minute interval'
    assert review.persisted?,
      'The bang! version of mark_correct! should save the record'
    Timecop.return
  end

  test 'due' do
    review
    topic_id = review.answer.topic.id
    start_time = Time.now
    Timecop.freeze start_time
    review.mark_correct!(start_time + 5.minutes)
    assert_empty Review.due(review.owner, topic_id),
      'review shouldnt be due after marking it correct'
    Timecop.travel review.next_review
    refute_empty Review.due(review.owner, topic_id),
      'review should show up on review list after it is due'
    assert_equal review.id, Review.due(review.owner, topic_id).first.id
    Timecop.return
  end

  test 'choices' do
    assert_equal review.choices, ChoiceFactory.build(review)
  end

end
