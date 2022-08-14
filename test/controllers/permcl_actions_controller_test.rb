require 'test_helper'

class PermclActionsControllerTest < ActionController::TestCase
  setup do
    @permcl_action = permcl_actions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:permcl_actions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create permcl_action" do
    assert_difference('PermclAction.count') do
      post :create, permcl_action: { title: @permcl_action.title }
    end

    assert_redirected_to permcl_action_path(assigns(:permcl_action))
  end

  test "should show permcl_action" do
    get :show, id: @permcl_action
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @permcl_action
    assert_response :success
  end

  test "should update permcl_action" do
    patch :update, id: @permcl_action, permcl_action: { title: @permcl_action.title }
    assert_redirected_to permcl_action_path(assigns(:permcl_action))
  end

  test "should destroy permcl_action" do
    assert_difference('PermclAction.count', -1) do
      delete :destroy, id: @permcl_action
    end

    assert_redirected_to permcl_actions_path
  end
end
