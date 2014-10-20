require 'test_helper'

class FactsControllerTest < ActionController::TestCase

  test 'fact creation' do
    post :create, topic_id: topic.id, user_id: user.id
    assert_response :success
  end
end
