require 'test_helper'

class AdmincontrolsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admincontrol = admincontrols(:one)
  end

  test "should get index" do
    get admincontrols_url
    assert_response :success
  end

  test "should get new" do
    get new_admincontrol_url
    assert_response :success
  end

  test "should create admincontrol" do
    assert_difference('Admincontrol.count') do
      post admincontrols_url, params: { admincontrol: {  } }
    end

    assert_redirected_to admincontrol_url(Admincontrol.last)
  end

  test "should show admincontrol" do
    get admincontrol_url(@admincontrol)
    assert_response :success
  end

  test "should get edit" do
    get edit_admincontrol_url(@admincontrol)
    assert_response :success
  end

  test "should update admincontrol" do
    patch admincontrol_url(@admincontrol), params: { admincontrol: {  } }
    assert_redirected_to admincontrol_url(@admincontrol)
  end

  test "should destroy admincontrol" do
    assert_difference('Admincontrol.count', -1) do
      delete admincontrol_url(@admincontrol)
    end

    assert_redirected_to admincontrols_url
  end
end
