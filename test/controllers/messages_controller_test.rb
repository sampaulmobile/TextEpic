require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  test "should get chillin" do
    get :chillin
    assert_response :success
  end

  test "should get textepic" do
    get :textepic
    assert_response :success
  end

end
