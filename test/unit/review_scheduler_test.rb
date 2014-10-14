require 'test_helper'
require 'review_scheduler'

class ReviewSchedulerTest < ActiveSupport::TestCase
  test '.calculate' do
    before      = Time.now
    after       = Time.now + 7.seconds
    assert_equal 7, (after - before).to_i
    reality     = ReviewScheduler.calculate(before, after)
    assert_equal after + 25.seconds, reality,
      'Expected ReviewScheduler to schedule a review 25 seconds in the future '\
      'give a 7 second review gap'

    before      = Time.now
    after       = Time.now + 600.seconds
    assert_equal 600, (after - before).to_i
    reality     = ReviewScheduler.calculate(before, after)
    assert_equal after + 3600.seconds, reality,
      'Expected ReviewScheduler to schedule a review 1 hour in the future '\
      'given a 10 minute review gap'

  end
end
