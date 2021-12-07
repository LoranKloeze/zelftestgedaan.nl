require "test_helper"

class SelfTestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @self_test = self_tests(:one)
  end

  test "should get index" do
    get self_tests_url
    assert_response :success
  end

  test "should get new" do
    get new_self_test_url
    assert_response :success
  end

  test "should create self_test" do
    assert_difference('SelfTest.count') do
      post self_tests_url, params: { self_test: { done_at: @self_test.done_at, ip_reference: @self_test.ip_reference, is_positive: @self_test.is_positive } }
    end

    assert_redirected_to self_test_url(SelfTest.last)
  end

  test "should show self_test" do
    get self_test_url(@self_test)
    assert_response :success
  end

  test "should get edit" do
    get edit_self_test_url(@self_test)
    assert_response :success
  end

  test "should update self_test" do
    patch self_test_url(@self_test), params: { self_test: { done_at: @self_test.done_at, ip_reference: @self_test.ip_reference, is_positive: @self_test.is_positive } }
    assert_redirected_to self_test_url(@self_test)
  end

  test "should destroy self_test" do
    assert_difference('SelfTest.count', -1) do
      delete self_test_url(@self_test)
    end

    assert_redirected_to self_tests_url
  end
end
