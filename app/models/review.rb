class Review < ActiveRecord::Base
  belongs_to :question
  belongs_to :fact
  belongs_to :owner, polymorphic: true
end
