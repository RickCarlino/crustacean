class Review < ActiveRecord::Base
  # TODO Default times for review fileds (last, next)
  belongs_to :question
  validates :question, presence: true
  belongs_to :fact
  validates :fact, presence: true
  belongs_to :owner, polymorphic: true
  belongs_to :answer

  delegate :answers, to: :question
  before_create { |rev| rev.next_review = Time.now }
end
