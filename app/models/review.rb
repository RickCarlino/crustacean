require 'choice_factory'
class Review < ActiveRecord::Base
  # TODO Default times for review fileds (last, next)
  belongs_to :question
  validates :question, presence: true
  belongs_to :fact
  validates :fact, presence: true
  belongs_to :owner, polymorphic: true
  belongs_to :answer

  delegate :answers, to: :question
  delegate :data, to: :answer

  before_create do |rev|
    rev.next_review = Time.now
    rev.last_review = Time.now
  end

  def self.random_review_for(user, topic)
    raise 'Do I still need this?'
    # TODO optimize. Don't feel like dealing with AR quirckiness right now
    ids  = Review.joins(:fact)
                 .where(owner: user, facts: {topics: topic}).pluck(:fact_id)
    fact = Fact.where.not(id: ids).order('random()').limit(1).first
    fact.populate_reviews(user)
  end

  def self.due(owner, topic_id)
    join  = "JOIN answers ON reviews.answer_id = answers.id JOIN questions on "\
            "questions.id = answers.question_id JOIN topics ON questions."\
            "topic_id = topics.id"
    query = "owner_type = ? AND owner_id = ? AND topics.id = ? AND"\
            " next_review < ?"
    terms = [query, owner.class, owner.id, topic_id, Time.now]
    self.joins(join).where(*terms)
  end

  # A list of possible choices against which the student can choose
  def choices
    # TODO Convert choices to a hypermedia URL to prevent N+1?
    @choices ||= ChoiceFactory.build(self)
  end

  # The `data` of the correct answer(s)
  def correct_answers
    Answer.where(question: question, fact: fact).pluck(:data)
  end

  # Propose an array of strings as an answer to the review's question
  def attempt(answer)
    answer.sort == correct_answers.sort
  end

  # TODO Test mark_correct, mark_incorrect and their bang(!) counterparts
  def mark_correct(time = Time.now)
    schedule    = ReviewScheduler.calculate(self.last_review, time)
    self.last_review = time
    self.next_review = schedule
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
