class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :prompt_label, :prompt, :choices_label, :choices

  def prompt_label
    object.answer.question.name
  end

  def choices_label
    object.question.name
  end

  def prompt
    object.answer.data
  end
end