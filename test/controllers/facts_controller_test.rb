require 'test_helper'

class FactsControllerTest < ActionController::TestCase

  test 'fact validation by question name' do
    ans = {this: 'that', the: 'other'}
    post :create, topic_id: topic.id, user_id: user.id, answers: ans
    assert_response 422
    assert_includes json[:answers], 'not a valid question name'
  end

  test 'fact creation' do
    ans = {한글: '명사', 영어: 'a noun', 품사: 'N', 발음: '명사.wav'}
    post :create, topic_id: topic.id, user_id: user.id, answers: ans
    assert_response :success
  end
end
