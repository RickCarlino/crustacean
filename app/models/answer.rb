class Answer < ActiveRecord::Base
  # TODO Validate uniqueness of `question <-> fact`
  belongs_to :question
  validates :question, presence: true

  belongs_to :fact
  validates :fact, presence: true

  has_many :reviews, dependent: :destroy

  delegate :topic, to: :question
  delegate :questions, to: :topic

  def make_reviews_for(owner, fact)
    case question.review_strategy
    when 'all'; populate_all_reviews(owner, fact)
    when 'one'; populate_one_review(owner, fact)
    else; false
    end
  end

  def populate_all_reviews(owner, fact)
    questions = topic.questions.where.not(id: id)
    questions.each do |ques|
      Review.find_or_create_by(fact: fact, owner: owner, question: ques)
    end
  end

  def populate_one_review(owner, fact)
    ques = question.only_review
    Review.find_or_create_by(fact: fact, owner: owner, question: ques)
  end

end
