class Fact < ActiveRecord::Base
  belongs_to :topic
  validates :topic, presence: true
  has_many :reviews, dependent: :destroy
  has_many :answers


end
