require 'test_helper'

class PlatformAdminsControllerTest < ActionController::TestCase
  setup do
    @platform_admin = platform_admins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:platform_admins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create platform_admin" do
    assert_difference('PlatformAdmin.count') do
      post :create, platform_admin: { organization_id: @platform_admin.organization_id, user_id: @platform_admin.user_id }
    end

    assert_redirected_to platform_admin_path(assigns(:platform_admin))
  end

  test "should show platform_admin" do
    get :show, id: @platform_admin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @platform_admin
    assert_response :success
  end

  test "should update platform_admin" do
    patch :update, id: @platform_admin, platform_admin: { organization_id: @platform_admin.organization_id, user_id: @platform_admin.user_id }
    assert_redirected_to platform_admin_path(assigns(:platform_admin))
  end

  test "should destroy platform_admin" do
    assert_difference('PlatformAdmin.count', -1) do
      delete :destroy, id: @platform_admin
    end

    assert_redirected_to platform_admins_path
  end
end
