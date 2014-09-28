class Question < ActiveRecord::Base
  # TODO validate uniqueness of :name within scope of topic.
  belongs_to :topic
  has_many :answers, dependent: :destroy
  has_many :reviews, dependent: :destroy

end
