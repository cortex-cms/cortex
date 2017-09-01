import {
  TOGGLE_TENANT_SWITCHER,
  SELECT_TENANT
} from 'constants/tenant_switcher'

const setTenantSwitcherReducer = ({tenant, tenants, current_user, environment,  environment_abbreviated}) => {
  const initialState = { tenant, tenantListActive: false, selected_tenant: tenant, tenants, current_user, environment,  environment_abbreviated }
  return function reducer(state = initialState, action) {
    switch (action.type) {
      case SELECT_TENANT:
        return {
          ...state,
          selected_tenant: action.payload
        };
      case TOGGLE_TENANT_SWITCHER:
        return {
          ...state,
          tenantListActive: !state.tenantListActive
        };
      default:
        return state
    }
  }
};

export default setTenantSwitcherReducer
