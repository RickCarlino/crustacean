require 'test_helper'

class FactTest < ActiveSupport::TestCase
  def fact
    topic.facts.first
  end

  test '#populate_reviews' do
    fact.populate_reviews(User.create)
    assert_equal Review.count, 15
    pending 'Verify that this method is actually creating the appropriate reviews and not just duplicating the same one.'
  end
end
