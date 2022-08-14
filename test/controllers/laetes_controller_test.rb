require 'test_helper'

class LaetesControllerTest < ActionController::TestCase
  setup do
    @laete = laetes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:laetes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create laete" do
    assert_difference('Laete.count') do
      post :create, laete: { cvet: @laete.cvet, image: @laete.image, lid: @laete.lid, price: @laete.price, qt: @laete.qt, razmer_eu: @laete.razmer_eu, razmer_ru: @laete.razmer_ru, sku: @laete.sku, sostav: @laete.sostav, title: @laete.title, url: @laete.url, uzor: @laete.uzor }
    end

    assert_redirected_to laete_path(assigns(:laete))
  end

  test "should show laete" do
    get :show, id: @laete
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @laete
    assert_response :success
  end

  test "should update laete" do
    patch :update, id: @laete, laete: { cvet: @laete.cvet, image: @laete.image, lid: @laete.lid, price: @laete.price, qt: @laete.qt, razmer_eu: @laete.razmer_eu, razmer_ru: @laete.razmer_ru, sku: @laete.sku, sostav: @laete.sostav, title: @laete.title, url: @laete.url, uzor: @laete.uzor }
    assert_redirected_to laete_path(assigns(:laete))
  end

  test "should destroy laete" do
    assert_difference('Laete.count', -1) do
      delete :destroy, id: @laete
    end

    assert_redirected_to laetes_path
  end
end
