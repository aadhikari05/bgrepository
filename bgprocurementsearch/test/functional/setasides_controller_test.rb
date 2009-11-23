require 'test_helper'

class SetasidesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:setasides)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_setaside
    assert_difference('Setaside.count') do
      post :create, :setaside => { }
    end

    assert_redirected_to setaside_path(assigns(:setaside))
  end

  def test_should_show_setaside
    get :show, :id => setasides(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => setasides(:one).id
    assert_response :success
  end

  def test_should_update_setaside
    put :update, :id => setasides(:one).id, :setaside => { }
    assert_redirected_to setaside_path(assigns(:setaside))
  end

  def test_should_destroy_setaside
    assert_difference('Setaside.count', -1) do
      delete :destroy, :id => setasides(:one).id
    end

    assert_redirected_to setasides_path
  end
end
