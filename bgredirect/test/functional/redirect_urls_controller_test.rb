require 'test_helper'

class RedirectUrlsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:redirect_urls)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_redirect_url
    assert_difference('RedirectUrl.count') do
      post :create, :redirect_url => { }
    end

    assert_redirected_to redirect_url_path(assigns(:redirect_url))
  end

  def test_should_show_redirect_url
    get :show, :id => redirect_urls(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => redirect_urls(:one).id
    assert_response :success
  end

  def test_should_update_redirect_url
    put :update, :id => redirect_urls(:one).id, :redirect_url => { }
    assert_redirected_to redirect_url_path(assigns(:redirect_url))
  end

  def test_should_destroy_redirect_url
    assert_difference('RedirectUrl.count', -1) do
      delete :destroy, :id => redirect_urls(:one).id
    end

    assert_redirected_to redirect_urls_path
  end
end
