require 'test_helper'

class CustomThreadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @custom_thread = custom_threads(:one)
  end

  test "should get index" do
    get custom_threads_url
    assert_response :success
  end

  test "should get new" do
    get new_custom_thread_url
    assert_response :success
  end

  test "should create custom_thread" do
    assert_difference('CustomThread.count') do
      post custom_threads_url, params: { custom_thread: { project_id: @custom_thread.project_id, title: @custom_thread.title } }
    end

    assert_redirected_to custom_thread_url(CustomThread.last)
  end

  test "should show custom_thread" do
    get custom_thread_url(@custom_thread)
    assert_response :success
  end

  test "should get edit" do
    get edit_custom_thread_url(@custom_thread)
    assert_response :success
  end

  test "should update custom_thread" do
    patch custom_thread_url(@custom_thread), params: { custom_thread: { project_id: @custom_thread.project_id, title: @custom_thread.title } }
    assert_redirected_to custom_thread_url(@custom_thread)
  end

  test "should destroy custom_thread" do
    assert_difference('CustomThread.count', -1) do
      delete custom_thread_url(@custom_thread)
    end

    assert_redirected_to custom_threads_url
  end
end
