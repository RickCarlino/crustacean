class Question < ActiveRecord::Base
  # TODO validate uniqueness of :name within scope of topic.
  belongs_to :topic
  # This is a useless association?
  belongs_to :question, inverse_of: :counter_question, class: ReviewScheme
  has_many   :answers, dependent: :destroy
  has_many   :reviews, dependent: :destroy
  has_many   :counter_questions, through: :review_schemes, class_name: 'Question'
  has_many   :review_schemes
  end
