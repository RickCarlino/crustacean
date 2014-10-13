# Performs calculations to give the reviewer a set of relevant choices based on
# the state of the review.
class ChoiceFactory
  # Returns an array of strings representing possible Answer#data().
  def self.build(review)
    correct     = review.correct_answers
    distraction = review
                    .answers.where
                    .not(id: review.answer.id)
                    .order('random()')
                    .limit(7)
                    .pluck(:data)
    (correct + distraction).shuffle.uniq
  end
end