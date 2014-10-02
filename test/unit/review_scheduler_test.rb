require 'test_helper'
require 'review_scheduler'

class ReviewSchedulerTest < ActiveSupport::TestCase
  test '.calculate' do
    before      = Time.now

    reality     = ReviewScheduler.calculate(before, (before + 7.seconds)).to_i
    expectation = (before + 25.seconds).to_i
    assert_equal expectation, reality,
      'a 7 second interval since the last review should schedule a review'\
      ' 25 seconds in the future'

    expectation = (before + 3600.seconds).to_i
    reality     = ReviewScheduler.calculate(before, (before + 601.seconds)).to_i
    assert_equal expectation, reality,
      'a 10 minute interval since the last review should schedule a review one'\
      ' hour in the future'
  end
end
