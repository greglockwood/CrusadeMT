require 'test_helper'

class FieldMTsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:field_m_ts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create field_m_ts" do
    assert_difference('FieldMTs.count') do
      post :create, :field_m_ts => { }
    end

    assert_redirected_to field_m_ts_path(assigns(:field_m_ts))
  end

  test "should show field_m_ts" do
    get :show, :id => field_m_ts(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => field_m_ts(:one).to_param
    assert_response :success
  end

  test "should update field_m_ts" do
    put :update, :id => field_m_ts(:one).to_param, :field_m_ts => { }
    assert_redirected_to field_m_ts_path(assigns(:field_m_ts))
  end

  test "should destroy field_m_ts" do
    assert_difference('FieldMTs.count', -1) do
      delete :destroy, :id => field_m_ts(:one).to_param
    end

    assert_redirected_to field_m_ts_path
  end
end
