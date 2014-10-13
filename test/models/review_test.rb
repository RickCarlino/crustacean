require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  define_method(:review) { @review ||= FactoryGirl.create(:review) }

  test '#mark_incorrect!' do
    time  = Time.now + 5.hours

    review.mark_incorrect!(time)

    last  = review.last_review.to_i
    _next = review.next_review.to_i

    assert_equal last, _next,
      'When incorrect, last_review and next_review should be equal'
    assert_equal 0, (last - _next),
      'Time difference should equal 0 when marked incorrect'
  end
end
