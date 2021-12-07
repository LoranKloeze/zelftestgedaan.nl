require 'test_helper'

class SelfTestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @self_test = self_tests(:one)
  end

  test 'should get index' do
    get self_tests_url
    assert_response :success
  end

  test 'should get new' do
    get new_self_test_url
    assert_response :success
  end

  test 'should create self_test' do
    assert_difference('SelfTest.count') do
      post self_tests_url,
           params: { self_test: { done_at: @self_test.done_at, is_positive: @self_test.is_positive } }
    end

    assert_redirected_to thanks_url
  end

end
