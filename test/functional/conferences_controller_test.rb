require 'test_helper'

class ConferencesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:conferences)
  end

  def test_should_get_new
    get_with admin, :new
    assert_response :success
  end

  def test_should_create_conference
    assert_difference('Conference.count') do
      post_with admin, :create, :conference => { :title => 'Test' }
    end

    assert_redirected_to conference_path(assigns(:conference))
  end

  def test_should_show_conference
    get :show, :id => conferences(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get_with admin, :edit, :id => conferences(:one).id
    assert_response :success
  end

  def test_should_update_conference
    put_with admin, :update, :id => conferences(:one).id,
        :conference => { :title => 'Test'}
    assert_redirected_to conference_path(assigns(:conference))
  end

  def test_should_destroy_conference
    assert_difference('Conference.count', -1) do
      delete_with admin, :destroy, :id => conferences(:one).id
    end

    assert_redirected_to conferences_path
  end
end
