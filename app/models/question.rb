class Question < ActiveRecord::Base
  # TODO validate uniqueness of :name within scope of topic.
  belongs_to :topic
  has_many :answers, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :only_review, class_name: 'Question'

  # ===== BEEP BOOP DANGER WARNING ========
  validates :review_strategy, format: { with: /all|none|one/,
    message: "must be 'all' 'none' or 'one'" }
  has_many :only_reviews, class_name: "Question", foreign_key: :only_review_id
  belongs_to :only_review, class_name: "Question", foreign_key: :only_review_id
  before_validation do |question|
    if question.review_strategy.in?(['all', 'none'])
      question.only_review_id = nil
    else
      question.review_strategy = 'one'
      err = [:review_strategy,
             'set to `one`, but you did not set an only_review_id']
      question.errors.add(*err) if question.only_review.blank?
    end
  end
  # === BOOP BEEP END COMPLICATED STUFF ===
  def make_reviews_for(owner, fact)
    answers.each { |ans| answers.make_reviews_for(owner, fact)}
    Review.create(owner: owner, fact: fact, question: self)
  end
end
