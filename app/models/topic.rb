# Used to organize Questions, Answers, Facts, Reviews
# Example Topics: "Western Leaders", "French Vocab", "Pokemon", "Dog Breeds"
class Topic < ActiveRecord::Base
  # TODO validate uniqueness of :name
  has_many :questions, dependent: :destroy
  has_many :facts, dependent: :destroy
end
