require 'test_helper'

class InfasControllerTest < ActionController::TestCase
  setup do
    @infa = infas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:infas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create infa" do
    assert_difference('Infa.count') do
      post :create, infa: { barcode: @infa.barcode, cat: @infa.cat, costprice: @infa.costprice, desc: @infa.desc, feature: @infa.feature, fid: @infa.fid, i_param: @infa.i_param, image: @infa.image, model: @infa.model, price: @infa.price, qt: @infa.qt, sku: @infa.sku, title: @infa.title, vendor: @infa.vendor }
    end

    assert_redirected_to infa_path(assigns(:infa))
  end

  test "should show infa" do
    get :show, id: @infa
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @infa
    assert_response :success
  end

  test "should update infa" do
    patch :update, id: @infa, infa: { barcode: @infa.barcode, cat: @infa.cat, costprice: @infa.costprice, desc: @infa.desc, feature: @infa.feature, fid: @infa.fid, i_param: @infa.i_param, image: @infa.image, model: @infa.model, price: @infa.price, qt: @infa.qt, sku: @infa.sku, title: @infa.title, vendor: @infa.vendor }
    assert_redirected_to infa_path(assigns(:infa))
  end

  test "should destroy infa" do
    assert_difference('Infa.count', -1) do
      delete :destroy, id: @infa
    end

    assert_redirected_to infas_path
  end
end
