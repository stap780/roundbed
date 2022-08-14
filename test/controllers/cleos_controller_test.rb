require 'test_helper'

class CleosControllerTest < ActionController::TestCase
  setup do
    @cleo = cleos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cleos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cleo" do
    assert_difference('Cleo.count') do
      post :create, cleo: { barcode: @cleo.barcode, cprice: @cleo.cprice, cvet: @cleo.cvet, desc: @cleo.desc, dizain: @cleo.dizain, image: @cleo.image, kvopred: @cleo.kvopred, obem: @cleo.obem, obrazmer: @cleo.obrazmer, okras: @cleo.okras, otdelka: @cleo.otdelka, plotnost: @cleo.plotnost, pr_razmer: @cleo.pr_razmer, price: @cleo.price, qt: @cleo.qt, razmer_upak: @cleo.razmer_upak, sdesc: @cleo.sdesc, sku: @cleo.sku, sostav: @cleo.sostav, tema: @cleo.tema, title: @cleo.title, tkan: @cleo.tkan, ves: @cleo.ves, vid_upak: @cleo.vid_upak, zast: @cleo.zast }
    end

    assert_redirected_to cleo_path(assigns(:cleo))
  end

  test "should show cleo" do
    get :show, id: @cleo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cleo
    assert_response :success
  end

  test "should update cleo" do
    patch :update, id: @cleo, cleo: { barcode: @cleo.barcode, cprice: @cleo.cprice, cvet: @cleo.cvet, desc: @cleo.desc, dizain: @cleo.dizain, image: @cleo.image, kvopred: @cleo.kvopred, obem: @cleo.obem, obrazmer: @cleo.obrazmer, okras: @cleo.okras, otdelka: @cleo.otdelka, plotnost: @cleo.plotnost, pr_razmer: @cleo.pr_razmer, price: @cleo.price, qt: @cleo.qt, razmer_upak: @cleo.razmer_upak, sdesc: @cleo.sdesc, sku: @cleo.sku, sostav: @cleo.sostav, tema: @cleo.tema, title: @cleo.title, tkan: @cleo.tkan, ves: @cleo.ves, vid_upak: @cleo.vid_upak, zast: @cleo.zast }
    assert_redirected_to cleo_path(assigns(:cleo))
  end

  test "should destroy cleo" do
    assert_difference('Cleo.count', -1) do
      delete :destroy, id: @cleo
    end

    assert_redirected_to cleos_path
  end
end
