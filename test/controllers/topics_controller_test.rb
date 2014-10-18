require 'test_helper'

class TopicsControllerTest < ActionController::TestCase
  test 'list all topics' do
    get :index, id: topic.id, user_id: user.id
    assert_equal 200, response.status
    refute_empty json[:topics]
    assert_equal topic.id, json[:topics][0][:id]
    assert_equal topic.name, json[:topics][0][:name]
  end

  test 'unauthorized access' do
    get :index, id: topic.id, user_id: 39393939393
    assert_equal 401, response.status
  end
end
