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

  def create_for(user, topic)
    raise 'lol'
  end

  def self.random_review_for(user, topic)
    # TODO optimize. Don't feel like dealing with AR quirckiness right now
    ids  = Review.joins(:fact)
                 .where(owner: user, fact: {topic: topic}).pluck(:fact_id)
    fact = Fact.where.not(id: ids).order('random()').limit(1).first
    fact.populate_reviews(user)
  end

  def self.due(owner)
    Review.where("next_review < ? AND owner_id = ? AND owner_type = ?",
                 Time.now,
                 owner.id,
                 owner.class)
  end

  def choices
    @choices ||= ChoiceFactory.build(self)
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
