import {
  UPDATE_ORGANIZATION_SCOPE,
  TOGGLE_TENANT_SWITCHER,
  SELECT_TENANT,
  TENANT_UPDATED,
  SUBLIST_CLICKED,
  TENANT_UPDATE_ERROR,
  TOGGLE_SIDEBAR,
  PAGINATE_BACK
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
    parent_tenant: currentUser.active_tenant.parent_id,
    tenant,
    csrf_token,
    sidebarExpanded,
    tenants,
    current_user: currentUser,
    environment,
    environment_abbreviated
  }
  return function reducer(state = initialState, action) {
    switch (action.type) {
      case PAGINATE_BACK:
        return {
          ...state,
          parent_tenant: action.payload
        };
      case SELECT_TENANT:
        return {
          ...state,
          selected_tenant: action.payload
        };
      case TENANT_UPDATED:
        return {
          ...state,
          current_user: action.payload,
          parent_tenant: action.payload.active_tenant.parent_id,
          tenantListActive: false
        }
      case SUBLIST_CLICKED:
        return {
          ...state,
          parent_tenant: action.payload
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
          parent_tenant: state.selected_tenant.parent_id
        };
      default:
        return state
    }
  }
};

export default tenantSwitcherReducer
