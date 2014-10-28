class ReviewScheme < ActiveRecord::Base
  belongs_to :question
  belongs_to :counter_question, class: Question
end
