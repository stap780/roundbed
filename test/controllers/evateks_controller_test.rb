require 'test_helper'

class EvateksControllerTest < ActionController::TestCase
  setup do
    @evatek = evateks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:evateks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create evatek" do
    assert_difference('Evatek.count') do
      post :create, evatek: { col: @evatek.col, country: @evatek.country, cprice: @evatek.cprice, cvet: @evatek.cvet, desc: @evatek.desc, eid: @evatek.eid, image: @evatek.image, oprice: @evatek.oprice, price: @evatek.price, qt: @evatek.qt, razmer_eu: @evatek.razmer_eu, razmer_ru: @evatek.razmer_ru, sdesc: @evatek.sdesc, sku: @evatek.sku, sostav: @evatek.sostav, title: @evatek.title, url: @evatek.url, uzor: @evatek.uzor, vendor: @evatek.vendor, weight: @evatek.weight }
    end

    assert_redirected_to evatek_path(assigns(:evatek))
  end

  test "should show evatek" do
    get :show, id: @evatek
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @evatek
    assert_response :success
  end

  test "should update evatek" do
    patch :update, id: @evatek, evatek: { col: @evatek.col, country: @evatek.country, cprice: @evatek.cprice, cvet: @evatek.cvet, desc: @evatek.desc, eid: @evatek.eid, image: @evatek.image, oprice: @evatek.oprice, price: @evatek.price, qt: @evatek.qt, razmer_eu: @evatek.razmer_eu, razmer_ru: @evatek.razmer_ru, sdesc: @evatek.sdesc, sku: @evatek.sku, sostav: @evatek.sostav, title: @evatek.title, url: @evatek.url, uzor: @evatek.uzor, vendor: @evatek.vendor, weight: @evatek.weight }
    assert_redirected_to evatek_path(assigns(:evatek))
  end

  test "should destroy evatek" do
    assert_difference('Evatek.count', -1) do
      delete :destroy, id: @evatek
    end

    assert_redirected_to evateks_path
  end
end
