class Fact < ActiveRecord::Base
  belongs_to :topic
  validates :topic, presence: true
  has_many :reviews, dependent: :destroy
  has_many :answers

  def create_review_for(user)
    answers.map { |ans| ans.create_review_for(user, topic) }
  end
end
