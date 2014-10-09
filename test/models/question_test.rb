require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  def test_before_validation_one
    question = build(:question, review_strategy: 'one')
    refute question.valid?
    list = question.errors.full_messages
    assert_includes list, "Review strategy set to `one`, but you did not set "\
                          "an only_review_id"
  end

  def test_before_validation_all
    question = build(:question, review_strategy: 'all')
    question.only_review_id = 123
    assert question.valid?
    assert_equal nil, question.only_review_id,
      "only_review_id should be reset if review_strategy is set to `all`"
  end

  def test_before_validation_none
    question = build(:question, review_strategy: 'none')
    question.only_review_id = 123
    assert question.valid?
    assert_equal nil, question.only_review_id,
      "only_review_id should be reset if review_strategy is set to `none`"
  end
end
