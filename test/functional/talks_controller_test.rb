require 'test_helper'

class TalksControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:talks)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_talk
    assert_difference('Talk.count') do
      post :create, :talk => { }
    end

    assert_redirected_to talk_path(assigns(:talk))
  end

  def test_should_show_talk
    get :show, :id => talks(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => talks(:one).id
    assert_response :success
  end

  def test_should_update_talk
    put :update, :id => talks(:one).id, :talk => { }
    assert_redirected_to talk_path(assigns(:talk))
  end

  def test_should_destroy_talk
    assert_difference('Talk.count', -1) do
      delete :destroy, :id => talks(:one).id
    end

    assert_redirected_to talks_path
  end
end
