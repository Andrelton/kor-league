require 'test_helper'

class UpdateControllerTest < ActionController::TestCase
  test "should get points" do
    get :points
    assert_response :success
  end

end
