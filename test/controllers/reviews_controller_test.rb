require 'test_helper'

class ReviewsControllerTest < ActionController::TestCase
  def setup
    Review.random_for(user, topic)
  end

  test 'list all reviews for a user' do
    get :index, topic_id: topic.id, user_id: user.id
    assert_response :success
    refute_empty json[:reviews]
    # TODO better assertions. Short on time today.
  end

  test 'create a review for a topic' do
    before = Review.due(user, topic)
    post :create, topic_id: topic.id, user_id: user.id
    assert_response :success
    after = Review.due(user, topic)
  end

  test 'answers a question correctly' do
    review  = Review.due(user, topic).sample
    answers = review.correct_answers
    patch :update, topic_id: topic.id,
                   user_id: user.id,
                   id: review.id,
                   proposed: answers
    assert_response :success
    assert_equal json[:proposed], json[:actual]
    assert json[:success]
  end

  test 'answers a question incorrectly' do
    review  = Review.due(user, topic).sample
    answers = ['wrong', 'not correct']
    patch :update, topic_id: topic.id,
                   user_id: user.id,
                   id: review.id,
                   proposed: answers
    assert_response :success
    refute_equal json[:proposed], json[:actual]
    refute json[:success]
  end

  test 'invalid responses' do
    review  = Review.due(user, topic).sample
    answers = {bad_data: 3.14159}
    patch :update, topic_id: topic.id,
                   user_id: user.id,
                   id: review.id,
                   proposed: answers
    assert_response 422
    assert_includes json[:proposed], "Proposed[0] isn't the right class"
  end
end
