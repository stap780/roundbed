require 'test_helper'

class BestsControllerTest < ActionController::TestCase
  setup do
    @best = bests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create best" do
    assert_difference('Best.count') do
      post :create, best: { cprice: @best.cprice, desc: @best.desc, image: @best.image, p_dlina: @best.p_dlina, p_forma: @best.p_forma, p_garant: @best.p_garant, p_napolnit: @best.p_napolnit, p_osoben: @best.p_osoben, p_razmer: @best.p_razmer, p_shirina: @best.p_shirina, p_sostav: @best.p_sostav, p_tipmatrasa: @best.p_tipmatrasa, p_ves: @best.p_ves, p_visota: @best.p_visota, price: @best.price, qt: @best.qt, sdesc: @best.sdesc, sku: @best.sku, sv_razmer: @best.sv_razmer, title: @best.title }
    end

    assert_redirected_to best_path(assigns(:best))
  end

  test "should show best" do
    get :show, id: @best
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @best
    assert_response :success
  end

  test "should update best" do
    patch :update, id: @best, best: { cprice: @best.cprice, desc: @best.desc, image: @best.image, p_dlina: @best.p_dlina, p_forma: @best.p_forma, p_garant: @best.p_garant, p_napolnit: @best.p_napolnit, p_osoben: @best.p_osoben, p_razmer: @best.p_razmer, p_shirina: @best.p_shirina, p_sostav: @best.p_sostav, p_tipmatrasa: @best.p_tipmatrasa, p_ves: @best.p_ves, p_visota: @best.p_visota, price: @best.price, qt: @best.qt, sdesc: @best.sdesc, sku: @best.sku, sv_razmer: @best.sv_razmer, title: @best.title }
    assert_redirected_to best_path(assigns(:best))
  end

  test "should destroy best" do
    assert_difference('Best.count', -1) do
      delete :destroy, id: @best
    end

    assert_redirected_to bests_path
  end
end
