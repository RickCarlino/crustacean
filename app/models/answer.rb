class Answer < ActiveRecord::Base
  # TODO Validate uniqueness of `question <-> fact`
  belongs_to :question
  validates :question, presence: true

  belongs_to :fact
  validates :fact, presence: true

  delegate :topic, to: :question
  delegate :questions, to: :topic

  def populate_reviews(owner)
    # For each of the answers questions, create a review pair, unless the
    # review pair is self referencing.
    questions.where.not(id: question.id) do |ques|
      # ^ The .not() part prevents self referencing questions like
      # `What is the color of red?` (tomato.color -> tomato.color)
      Review.create(fact: self, question: ques, owner: owner)
    end
  end
end
