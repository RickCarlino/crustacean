class Question < ActiveRecord::Base
  belongs_to :topic
  has_many :answers, dependent: :destroy
  has_many :reviews, dependent: :destroy
end
