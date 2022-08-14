require 'test_helper'

class MarcsControllerTest < ActionController::TestCase
  setup do
    @marc = marcs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:marcs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create marc" do
    assert_difference('Marc.count') do
      post :create, marc: { cprice: @marc.cprice, desc: @marc.desc, image: @marc.image, price: @marc.price, qt: @marc.qt, sdesc: @marc.sdesc, sku: @marc.sku, title: @marc.title }
    end

    assert_redirected_to marc_path(assigns(:marc))
  end

  test "should show marc" do
    get :show, id: @marc
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @marc
    assert_response :success
  end

  test "should update marc" do
    patch :update, id: @marc, marc: { cprice: @marc.cprice, desc: @marc.desc, image: @marc.image, price: @marc.price, qt: @marc.qt, sdesc: @marc.sdesc, sku: @marc.sku, title: @marc.title }
    assert_redirected_to marc_path(assigns(:marc))
  end

  test "should destroy marc" do
    assert_difference('Marc.count', -1) do
      delete :destroy, id: @marc
    end

    assert_redirected_to marcs_path
  end
end
