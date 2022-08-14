require 'test_helper'

class AsabsControllerTest < ActionController::TestCase
  setup do
    @asab = asabs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:asabs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create asab" do
    assert_difference('Asab.count') do
      post :create, asab: { aid: @asab.aid, cprice: @asab.cprice, desc: @asab.desc, image: @asab.image, price: @asab.price, qt: @asab.qt, sdesc: @asab.sdesc, sku: @asab.sku, sostav: @asab.sostav, title: @asab.title }
    end

    assert_redirected_to asab_path(assigns(:asab))
  end

  test "should show asab" do
    get :show, id: @asab
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @asab
    assert_response :success
  end

  test "should update asab" do
    patch :update, id: @asab, asab: { aid: @asab.aid, cprice: @asab.cprice, desc: @asab.desc, image: @asab.image, price: @asab.price, qt: @asab.qt, sdesc: @asab.sdesc, sku: @asab.sku, sostav: @asab.sostav, title: @asab.title }
    assert_redirected_to asab_path(assigns(:asab))
  end

  test "should destroy asab" do
    assert_difference('Asab.count', -1) do
      delete :destroy, id: @asab
    end

    assert_redirected_to asabs_path
  end
end
