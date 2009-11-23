require 'test_helper'

class OpportunitiesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:opportunities)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_opportunity
    assert_difference('Opportunity.count') do
      post :create, :opportunity => { }
    end

    assert_redirected_to opportunity_path(assigns(:opportunity))
  end

  def test_should_show_opportunity
    get :show, :id => opportunities(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => opportunities(:one).id
    assert_response :success
  end

  def test_should_update_opportunity
    put :update, :id => opportunities(:one).id, :opportunity => { }
    assert_redirected_to opportunity_path(assigns(:opportunity))
  end

  def test_should_destroy_opportunity
    assert_difference('Opportunity.count', -1) do
      delete :destroy, :id => opportunities(:one).id
    end

    assert_redirected_to opportunities_path
  end
end
