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
    note """This is an example of a creating a topic. Questions are created by
    providing a set of key value pairs that correspond to the question names and
    the questions that it will be quized against. You must explicitly state
    which questions you want a question to quiz against because it does not
    always make sense to quiz against all questions. In this example, we are
    creating a topic called 'chickens' and will review the 'breed' question
    against the 'color' and 'type' questions. """
    before = Topic.count
    params =  {name: 'chickens',
               user_id: user.id,
               questions: {breed: [:color, :type],
                           type:  [],
                           color:  [:breed]}}
    post :create, params
    topic = Topic.find(json[:topic][:id])
    after = Topic.count
    assert_response :success
    assert_equal 'chickens', json[:topic][:name]
    assert_equal 'chickens', topic.name
    expected_questions = ["breed", "color", "type"]
    actual_questions   = json[:topic][:questions].sort
    assert_equal expected_questions, actual_questions
    assert before < after
  end
end
