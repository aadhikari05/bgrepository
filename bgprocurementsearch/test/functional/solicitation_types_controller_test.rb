require 'test_helper'

class SolicitationTypesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:solicitation_types)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_solicitation_type
    assert_difference('SolicitationType.count') do
      post :create, :solicitation_type => { }
    end

    assert_redirected_to solicitation_type_path(assigns(:solicitation_type))
  end

  def test_should_show_solicitation_type
    get :show, :id => solicitation_types(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => solicitation_types(:one).id
    assert_response :success
  end

  def test_should_update_solicitation_type
    put :update, :id => solicitation_types(:one).id, :solicitation_type => { }
    assert_redirected_to solicitation_type_path(assigns(:solicitation_type))
  end

  def test_should_destroy_solicitation_type
    assert_difference('SolicitationType.count', -1) do
      delete :destroy, :id => solicitation_types(:one).id
    end

    assert_redirected_to solicitation_types_path
  end
end
