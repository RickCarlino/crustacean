require 'test_helper'

class FactTest < ActiveSupport::TestCase
  def fact
    topic.facts.first
    # @topic ||= FactoryGirl.create(:topic, :pokemon).facts.first
  end

  # PROBLEM: Do we add a whitelist feature or a blacklist feature?
  # Not all question pairs are appropriate for review. A blacklist feature would
  # prevent weird or impossibly difficult reviews from happening.
  # Appropriate examples:
     # {"Yokohama"=>["walnut"]},
     # {"Yokohama"=>["light breed", "softfeather"]},
     # {"Yokohama"=>["rarely"]},
     # {"softfeather"=>["Yokohama"]},
     # {"walnut"=>["Yokohama"]},
     # {"rarely"=>["Yokohama"]},
     # {"light breed"=>["Yokohama"]},
  # Bad examples:
     # {"softfeather"=>["walnut"]},
     # {"softfeather"=>["rarely"]},
     # {"rarely"=>["walnut"]},
     # {"rarely"=>["light breed", "softfeather"]}]
     # {"walnut"=>["light breed", "softfeather"]},
     # {"light breed"=>["walnut"]},
     # {"walnut"=>["rarely"]},
     # {"light breed"=>["rarely"]},

  test '#populate_reviews' do
    fact.populate_reviews(User.create)
    assert_equal 15, Review.count
    assert_equal [1], Review.all.pluck(:fact_id).uniq,
      '#populate_reviews() should only populate reviews for one fact'
    m = Review.all.map{|r| { r.answer.data => r.question.answers.map(&:data) } }
    binding.pry
  end
end
