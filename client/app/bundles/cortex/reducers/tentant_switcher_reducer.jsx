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

const checkActiveTenant = (active_tenant, current_user) => {
  if (current_user.active_tenant === null) {
    return Object.assign({}, current_user, { active_tenant: active_tenant })
  }
  return current_user
}

const tenantSwitcherReducer = ({active_tenant, csrf_token, sidebarExpanded, tenants, current_user, environment,  environment_abbreviated}) => {
  const currentUser = checkActiveTenant(active_tenant, current_user);
  const initialState = {
    tenantListActive: false,
    selectedTenant: currentUser.active_tenant,
    parentTenant: currentUser.active_tenant.parent_id,
    tenantSyncedWithDB: true,
    csrf_token,
    sidebarExpanded,
    tenants,
    currentUser: currentUser,
    environment,
    environment_abbreviated
  }
  return function reducer(state = initialState, action) {
    switch (action.type) {
      case PAGINATE_BACK:
        return {
          ...state,
          parentTenant: action.payload
        };
      case SELECT_TENANT:
        return {
          ...state,
          selectedTenant: action.payload,
          tenantSyncedWithDB: state.currentUser.active_tenant.id === action.payload.id
        };
      case TENANT_UPDATED:
        return {
          ...state,
          currentUser: action.payload,
          parentTenant: action.payload.active_tenant.parent_id,
          tenantSyncedWithDB: true,
          tenantListActive: false
        }
      case SUBLIST_CLICKED:
        return {
          ...state,
          parentTenant: action.payload
        }
      case TENANT_UPDATE_ERROR:
        return {
          ...state,
          selectedTenant: state.current_user.active_tenant
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
          parentTenant: state.selectedTenant.parent_id
        };
      default:
        return state
    }
  }
};

export default tenantSwitcherReducer
