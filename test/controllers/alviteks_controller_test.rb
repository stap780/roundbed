require 'test_helper'

class AlviteksControllerTest < ActionController::TestCase
  setup do
    @alvitek = alviteks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alviteks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alvitek" do
    assert_difference('Alvitek.count') do
      post :create, alvitek: { aid: @alvitek.aid, barcode: @alvitek.barcode, cat: @alvitek.cat, col: @alvitek.col, country: @alvitek.country, cvet: @alvitek.cvet, desc: @alvitek.desc, image: @alvitek.image, kol_upak: @alvitek.kol_upak, line: @alvitek.line, material: @alvitek.material, mprice: @alvitek.mprice, napolnitel: @alvitek.napolnitel, napolnitel_chehla: @alvitek.napolnitel_chehla, napolnitel_yadra: @alvitek.napolnitel_yadra, okantovka: @alvitek.okantovka, plotnost: @alvitek.plotnost, podderjka: @alvitek.podderjka, price: @alvitek.price, qt: @alvitek.qt, razm_nav: @alvitek.razm_nav, razm_podod: @alvitek.razm_podod, razmer: @alvitek.razmer, razmer_prostini: @alvitek.razmer_prostini, sku: @alvitek.sku, sostav: @alvitek.sostav, sostav_tkan: @alvitek.sostav_tkan, teplota: @alvitek.teplota, tip_krepl: @alvitek.tip_krepl, tip_prostini: @alvitek.tip_prostini, tip_stejki: @alvitek.tip_stejki, tip_upak: @alvitek.tip_upak, tip_zast: @alvitek.tip_zast, tip_zast_navol: @alvitek.tip_zast_navol, tip_zast_podod: @alvitek.tip_zast_podod, title: @alvitek.title, tkan: @alvitek.tkan, tkan_niz: @alvitek.tkan_niz, tkan_verh: @alvitek.tkan_verh, upak: @alvitek.upak, vendor: @alvitek.vendor, vendor: @alvitek.vendor, ves_napolnitel: @alvitek.ves_napolnitel, ves_napolnitel_yadra: @alvitek.ves_napolnitel_yadra, ves_nopolnitel_chehla: @alvitek.ves_nopolnitel_chehla, visota: @alvitek.visota }
    end

    assert_redirected_to alvitek_path(assigns(:alvitek))
  end

  test "should show alvitek" do
    get :show, id: @alvitek
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alvitek
    assert_response :success
  end

  test "should update alvitek" do
    patch :update, id: @alvitek, alvitek: { aid: @alvitek.aid, barcode: @alvitek.barcode, cat: @alvitek.cat, col: @alvitek.col, country: @alvitek.country, cvet: @alvitek.cvet, desc: @alvitek.desc, image: @alvitek.image, kol_upak: @alvitek.kol_upak, line: @alvitek.line, material: @alvitek.material, mprice: @alvitek.mprice, napolnitel: @alvitek.napolnitel, napolnitel_chehla: @alvitek.napolnitel_chehla, napolnitel_yadra: @alvitek.napolnitel_yadra, okantovka: @alvitek.okantovka, plotnost: @alvitek.plotnost, podderjka: @alvitek.podderjka, price: @alvitek.price, qt: @alvitek.qt, razm_nav: @alvitek.razm_nav, razm_podod: @alvitek.razm_podod, razmer: @alvitek.razmer, razmer_prostini: @alvitek.razmer_prostini, sku: @alvitek.sku, sostav: @alvitek.sostav, sostav_tkan: @alvitek.sostav_tkan, teplota: @alvitek.teplota, tip_krepl: @alvitek.tip_krepl, tip_prostini: @alvitek.tip_prostini, tip_stejki: @alvitek.tip_stejki, tip_upak: @alvitek.tip_upak, tip_zast: @alvitek.tip_zast, tip_zast_navol: @alvitek.tip_zast_navol, tip_zast_podod: @alvitek.tip_zast_podod, title: @alvitek.title, tkan: @alvitek.tkan, tkan_niz: @alvitek.tkan_niz, tkan_verh: @alvitek.tkan_verh, upak: @alvitek.upak, vendor: @alvitek.vendor, vendor: @alvitek.vendor, ves_napolnitel: @alvitek.ves_napolnitel, ves_napolnitel_yadra: @alvitek.ves_napolnitel_yadra, ves_nopolnitel_chehla: @alvitek.ves_nopolnitel_chehla, visota: @alvitek.visota }
    assert_redirected_to alvitek_path(assigns(:alvitek))
  end

  test "should destroy alvitek" do
    assert_difference('Alvitek.count', -1) do
      delete :destroy, id: @alvitek
    end

    assert_redirected_to alviteks_path
  end
end
