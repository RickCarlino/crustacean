class TopicSerializer < ActiveModel::Serializer
  attributes :id, :name, :questions

  def questions
    object.questions.pluck(:name)
  end
end