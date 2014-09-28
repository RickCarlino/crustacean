class Fact < ActiveRecord::Base
  belongs_to :topic
  has_many :reviews, dependent: :destroy
end
