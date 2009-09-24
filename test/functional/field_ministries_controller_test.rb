require 'test_helper'

class FieldMinistriesControllerTest < ActionController::TestCase

  test "should create field_ministry" do
    FieldMinistry.any_instance.expects(:save).returns(true)
    post :create, :field_ministry => { }
    assert_not_nil flash[:notice], "Flash notice wasn't set when creating field_ministry successfully."
    assert_response :redirect
  end

  test "should handle failure to create field_ministry" do
    FieldMinistry.any_instance.expects(:save).returns(false)
    post :create, :field_ministry => { }
    assert_template "new"
  end

  test "should destroy field_ministry" do
    FieldMinistry.any_instance.expects(:destroy).returns(true)
    delete :destroy, :id => field_ministries(:one).to_param
    assert_not_nil flash[:notice], "Flash notice wasn't set when deleting field_ministry"
    assert_response :redirect
  end

  test "should handle failure to destroy field_ministry" do
    FieldMinistry.any_instance.expects(:destroy).returns(false)    
    delete :destroy, :id => field_ministries(:one).to_param
    assert_response :redirect
  end

  test "should get edit for field_ministry" do
    get :edit, :id => field_ministries(:one).to_param
    assert_response :success
  end

  test "should get index for field_ministries" do
    get :index
    assert_response :success
    assert_not_nil assigns(:field_ministries)
  end

  test "should get new for field_ministry" do
    get :new
    assert_response :success
  end

  test "should get show for field_ministry" do
    get :show, :id => field_ministries(:one).to_param
    assert_response :success
  end

  test "should update field_ministry" do
    FieldMinistry.any_instance.expects(:save).returns(true)
    put :update, :id => field_ministries(:one).to_param, :field_ministry => { }
    assert_response :redirect
    assert_not_nil flash[:notice], "Flash notice should be set when updating field_ministry"
  end

  test "should handle failure to update field_ministry" do
    FieldMinistry.any_instance.expects(:save).returns(false)
    put :update, :id => field_ministries(:one).to_param, :field_ministry => { }
    assert_template "edit"
  end

end