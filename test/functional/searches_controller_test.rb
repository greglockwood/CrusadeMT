require 'test_helper'

class SearchesControllerTest < ActionController::TestCase

  test "should create search" do
    Search.any_instance.expects(:save).returns(true)
    post :create, :search => { }
    #assert_response :redirect
    assert_not_nil flash[:notice]
  end

  test "should handle failure to create search" do
    Search.any_instance.expects(:save).returns(false)
    post :create, :search => { }
    assert_template "show"
    assert_not_nil flash[:error]
  end

  test "should get new for search" do
    get :new
    assert_response :success
  end

  test "should get show for search" do
    get :show, :id => searches(:one).to_param
    assert_response :success
  end
end