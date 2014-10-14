require 'test_helper'
require 'choice_factory'

class ChoiceFactoryTest < ActiveSupport::TestCase
  test 'build' do
        # OPTIMIZE comprehensiveness of this test
    topic   = create(:topic)
    user    = create(:user)
    answer  = topic.facts.sample.answers.sample
    review  = answer.create_review_for(user, topic).first
    results = ChoiceFactory.build review
    refute_empty results,
      'ChoiceFactory should always return choices (not empty)'
    results.each do |result|
      assert Answer.find_by(data: result).is_a?(Answer),
        'Results should represent data from real answers'
      refute_equal review.answer.data, result
    end
  end
end
