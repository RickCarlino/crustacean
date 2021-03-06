class Answer < ActiveRecord::Base
  # TODO Validate uniqueness of `question <-> fact`
  belongs_to :question
  validates :question, presence: true

  belongs_to :fact
  validates :fact, presence: true

  has_many :reviews, dependent: :destroy

  delegate :topic, to: :question
  delegate :questions, to: :topic

  def create_review_for(user, topic)
    question.counter_questions.map do |ques|
      Review.create(owner: user, question: ques, answer: self, fact: fact)
    end
  end
end
