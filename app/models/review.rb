class Review < ActiveRecord::Base
  # TODO Default times for review fileds (last, next)
  belongs_to :question
  validates :question, presence: true
  belongs_to :fact
  validates :fact, presence: true
  belongs_to :owner, polymorphic: true
  belongs_to :answer

  delegate :answers, to: :question
  before_create do |rev|
    rev.next_review = Time.now
    rev.last_review = Time.now
  end
  # TODO Test mark_correct, mark_incorrect and their bang(!) counterparts
  def mark_correct(time = Time.now)
    schedule    = ReviewScheduler.calculate(last_review, time)
    last_review = time
    next_review = schedule
  end

  def mark_correct!(time = Time.now)
    mark_correct(time)
    save
  end

  def mark_incorrect(time = Time.now)
    last_review = time
    next_review = time
  end

  def mark_incorrect!(time = Time.now)
    mark_incorrect
    save!
  end
end
