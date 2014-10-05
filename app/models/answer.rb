class Answer < ActiveRecord::Base
  # TODO Validate uniqueness of `question <-> fact`
  belongs_to :question
  validates :question, presence: true

  belongs_to :fact
  validates :fact, presence: true

  has_many :reviews, dependent: :destroy

  delegate :topic, to: :question
  delegate :questions, to: :topic

  def populate_reviews(owner)
    # For each of the answers questions, create a review pair, unless the
    # review pair is self referencing or inadequately unique to be useful for
    #review.
    # TODO Add a select statment here so it doesnt return crappy responses like
    # [nil, #<answer>, nil]
    questions.where.not(id: question.id).map do |ques|
      # ^ The .not() part prevents self referencing questions like
      # `What is the color of red?` (tomato.color -> tomato.color)
      if ques.special || question.special
        # ^ Check that atleast one side of the reivew is uniquely identifiable.
        Review.create(fact: fact,
                      question: ques,
                      answer: self,
                      owner: owner)
      end
    end
  end

end
