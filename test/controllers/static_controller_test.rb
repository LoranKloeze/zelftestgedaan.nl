require "test_helper"

class StaticControllerTest < ActionDispatch::IntegrationTest
  test "should get thanks" do
    get static_thanks_url
    assert_response :success
  end

  test "should get privacy" do
    get static_privacy_url
    assert_response :success
  end
end
