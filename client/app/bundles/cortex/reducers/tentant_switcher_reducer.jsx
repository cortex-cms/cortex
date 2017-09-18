import {
  UPDATE_ORGANIZATION_SCOPE,
  TOGGLE_TENANT_SWITCHER,
  SELECT_TENANT,
  TENANT_UPDATED,
  TENANT_UPDATE_ERROR,
  TOGGLE_SIDEBAR
} from 'constants/tenant_switcher'

const checkActiveTenant = (tenant, current_user) => {
  if (current_user.active_tenant === null) {
    return Object.assign({}, current_user, { active_tenant: tenant })
  }
  return current_user
}

const tenantSwitcherReducer = ({tenant, csrf_token, sidebarExpanded, tenants, current_user, environment,  environment_abbreviated}) => {
  const currentUser = checkActiveTenant(tenant, current_user)
  const initialState = {
    tenantListActive: false,
    selected_tenant: currentUser.active_tenant,
    tenant,
    csrf_token,
    sidebarExpanded,
    tenants,
    organization_displayed: (currentUser.active_tenant.parent_id || currentUser.active_tenant.id),
    current_user: currentUser,
    environment,
    environment_abbreviated
  }
  return function reducer(state = initialState, action) {
    switch (action.type) {
      case SELECT_TENANT:
        return {
          ...state,
          selected_tenant: action.payload
        };
      case TENANT_UPDATED:
        return {
          ...state,
          current_user: action.payload,
          tenantListActive: false
        }
      case UPDATE_ORGANIZATION_SCOPE:
        return {
          ...state,
          organization_displayed: action.payload
        }
      case TENANT_UPDATE_ERROR:
        return {
          ...state,
          selected_tenant: state.current_user.active_tenant
        }
      case TOGGLE_SIDEBAR:
        return {
          ...state,
          sidebarExpanded: !state.sidebarExpanded,
          tenantListActive: false
        };
      case TOGGLE_TENANT_SWITCHER:
        return {
          ...state,
          tenantListActive: !state.tenantListActive,
          organization_displayed: state.selected_tenant.parent_id || state.selected_tenant.id
        };
      default:
        return state
    }
  }
};

export default tenantSwitcherReducer
