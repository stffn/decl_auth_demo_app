require 'test_helper'

class ConferencesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:conferences)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_conferences
    assert_difference('Conferences.count') do
      post :create, :conferences => { }
    end

    assert_redirected_to conferences_path(assigns(:conferences))
  end

  def test_should_show_conferences
    get :show, :id => conferences(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => conferences(:one).id
    assert_response :success
  end

  def test_should_update_conferences
    put :update, :id => conferences(:one).id, :conferences => { }
    assert_redirected_to conferences_path(assigns(:conferences))
  end

  def test_should_destroy_conferences
    assert_difference('Conferences.count', -1) do
      delete :destroy, :id => conferences(:one).id
    end

    assert_redirected_to conferences_path
  end
end
