require 'test_helper'

class PermclsControllerTest < ActionController::TestCase
  setup do
    @permcl = permcls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:permcls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create permcl" do
    assert_difference('Permcl.count') do
      post :create, permcl: { systitle: @permcl.systitle, title: @permcl.title }
    end

    assert_redirected_to permcl_path(assigns(:permcl))
  end

  test "should show permcl" do
    get :show, id: @permcl
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @permcl
    assert_response :success
  end

  test "should update permcl" do
    patch :update, id: @permcl, permcl: { systitle: @permcl.systitle, title: @permcl.title }
    assert_redirected_to permcl_path(assigns(:permcl))
  end

  test "should destroy permcl" do
    assert_difference('Permcl.count', -1) do
      delete :destroy, id: @permcl
    end

    assert_redirected_to permcls_path
  end
end
