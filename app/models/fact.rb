class Fact < ActiveRecord::Base
  belongs_to :topic
  validates :topic, presence: true
  has_many :reviews, dependent: :destroy
  has_many :answers

  def populate_reviews(owner)
    answers.map { |ans| ans.populate_reviews(owner) }
  end
end
