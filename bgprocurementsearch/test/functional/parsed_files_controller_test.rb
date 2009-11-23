require 'test_helper'

class ParsedFilesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:parsed_files)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_parsed_file
    assert_difference('ParsedFile.count') do
      post :create, :parsed_file => { }
    end

    assert_redirected_to parsed_file_path(assigns(:parsed_file))
  end

  def test_should_show_parsed_file
    get :show, :id => parsed_files(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => parsed_files(:one).id
    assert_response :success
  end

  def test_should_update_parsed_file
    put :update, :id => parsed_files(:one).id, :parsed_file => { }
    assert_redirected_to parsed_file_path(assigns(:parsed_file))
  end

  def test_should_destroy_parsed_file
    assert_difference('ParsedFile.count', -1) do
      delete :destroy, :id => parsed_files(:one).id
    end

    assert_redirected_to parsed_files_path
  end
end
