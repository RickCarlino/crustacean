class Review < ActiveRecord::Base
  # TODO Default times for review fileds (last, next)
  belongs_to :question
  validates :question, presence: true
  belongs_to :fact
  validates :fact, presence: true
  belongs_to :owner, polymorphic: true

  delegate :answers, to: :question

  def answer_key
    { question.name => answers.pluck(:data) }
  end
end
