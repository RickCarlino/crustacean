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

  test 'create topic' do
    before = Topic.count
    params =  {name: 'chickens',
               user_id: user.id,
               questions: {breed: [:color, :type],
                           type:  [],
                           color:  [:breed, :breed, :breed]}}
    post :create, params
    binding.pry
    after = Topic.count
    assert_response :success
    assert_equal 'chickens', json[:topic][:name]
    assert before < after
  end

  # test 'bad counterquestion selection' do
  #   raise '
  #   Try to break Topics::Create. Probably needs to be a mutation unit test, though.'
  # end
end
