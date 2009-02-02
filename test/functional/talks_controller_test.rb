require 'test_helper'

class TalksControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index, :conference_id => conferences(:one)
    assert_response :success
    assert_not_nil assigns(:talks)
  end

  def test_should_get_new
    get_with admin, :new, :conference_id => conferences(:one)
    assert_response :success
  end

  def test_should_create_talk
    assert_difference('Talk.count') do
      post_with admin, :create, :conference_id => conferences(:one).id, 
          :talk => { :user_id => admin.id }
    end

    assert_redirected_to conference_talk_path(assigns(:talk).conference, assigns(:talk))
  end

  def test_should_show_talk
    get :show, :id => talks(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get_with admin, :edit, :id => talks(:one).id, :conference_id => talks(:one).conference_id
    assert_response :success
  end

  def test_should_update_talk
    put_with admin, :update, :conference_id => talks(:one).conference_id,
        :id => talks(:one).id, :talk => { }
    assert_redirected_to conference_talk_path(assigns(:talk).conference, assigns(:talk))
  end

  def test_should_destroy_talk
    conf = talks(:one).conference
    assert_difference('Talk.count', -1) do
      delete_with admin, :destroy, :id => talks(:one).id, :conference_id => conf.id
    end

    assert_redirected_to conference_path(conf)
  end
end
