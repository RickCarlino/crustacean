class Fact < ActiveRecord::Base
  belongs_to :topic
  validates :topic, presence: true
  has_many :reviews, dependent: :destroy
  has_many :answers

  def populate_reviews(owner)
    # questions.map { |ans| ans.populate_reviews(owner) }
    topic.questions.map { |question| question.make_reviews_for(owner, fact) }
  end
end
