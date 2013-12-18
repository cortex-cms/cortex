require 'test_helper'

class TenantsControllerTest < ActionController::TestCase

  setup do
    @tenant = tenants(:tanf)
  end

  setup do
    @request.env['HTTP_AUTHORIZATION'] = 'Basic ' + Base64::encode64('surgeon:welcome1')
  end

  test 'should get index' do
    get :index, {:format => :json}
    assert_response :success
    assert_not_nil assigns(:tenants)
  end

  test 'should get tenant' do
    get :show, {:id => @tenant.id, :format => :json}
    assert_response :success
  end

=begin
  test 'should create tenant' do
    assert_difference('Tenant.count') do
      post :create, tenant: {name: @tenant.name,
                            parent_id: @tenant.parent_id,
                            contact_name: @tenant.contact_name,
                            contact_email: @tenant.contact_email,
                            contact_phone: @tenant.contact_phone,
                            active_at: @tenant.active_at,
                            deactive_at: @tenant.deactive_at,
                            contract: @tenant.contract,
                            did: @tenant.did,
                            subdomain: @tenant.subdomain}
    end
  end
=end

=begin
  test 'should get tenant' do
    get :show, {:id => @tenant.id, :format => :json}
    assert_response :success
  end
=end

=begin
  setup do
    @tenant = tenants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tenants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tenant" do
    assert_difference('Tenant.count') do
      post :create, tenant: { active_at: @tenant.active_at, contact_email: @tenant.contact_email, contact_name: @tenant.contact_name, contact_phone: @tenant.contact_phone, contract: @tenant.contract, depth: @tenant.depth, did: @tenant.did, inactive_at: @tenant.inactive_at, lft: @tenant.lft, name: @tenant.name, parent_id: @tenant.parent_id, rgt: @tenant.rgt }
    end

    assert_redirected_to tenant_path(assigns(:tenant))
  end

  test "should show tenant" do
    get :show, id: @tenant
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tenant
    assert_response :success
  end

  test "should update tenant" do
    patch :update, id: @tenant, tenant: { active_at: @tenant.active_at, contact_email: @tenant.contact_email, contact_name: @tenant.contact_name, contact_phone: @tenant.contact_phone, contract: @tenant.contract, depth: @tenant.depth, did: @tenant.did, inactive_at: @tenant.inactive_at, lft: @tenant.lft, name: @tenant.name, parent_id: @tenant.parent_id, rgt: @tenant.rgt }
    assert_redirected_to tenant_path(assigns(:tenant))
  end

  test "should destroy tenant" do
    assert_difference('Tenant.count', -1) do
      delete :destroy, id: @tenant
    end

    assert_redirected_to tenants_path
  end
=end
end
