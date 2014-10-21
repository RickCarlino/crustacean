require 'test_helper'

class FactsControllerTest < ActionController::TestCase

  test 'fact creation' do
    ans = {this: 'that', the: 'other'}
    post :create, topic_id: topic.id, user_id: user.id, answers: ans
    assert_response :success
  end
end
