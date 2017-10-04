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

const tenantSwitcherReducer = ({active_tenant, csrf_token, sidebarExpanded, tenants, current_user, environment, environment_abbreviated}) => {
  const initialState = {
    tenantListActive: false,
    activeTenant: active_tenant,
    parentTenant: active_tenant.parent_id,
    tenantSyncedWithDB: true,
    csrf_token,
    sidebarExpanded,
    tenants,
    currentUser: current_user,
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
          activeTenant: action.payload,
          tenantSyncedWithDB: state.activeTenant.id === action.payload.id
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
          activeTenant: state.active_tenant
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
          parentTenant: state.activeTenant.parent_id
        };
      default:
        return state
    }
  }
};

export default tenantSwitcherReducer
