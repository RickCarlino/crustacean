class Topic < ActiveRecord::Base
  has_many :questions, dependent: :destroy
  has_many :facts, dependent: :destroy
end
