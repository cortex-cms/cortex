import {
  TOGGLE
} from 'constants/tenant_switcher'

const setTenantSwitcherReducer = ({tenant, current_user, environment,  environment_abbreviated}) => {
  const initialState = { tenant, current_user, environment,  environment_abbreviated }
  return function reducer(state = initialState, action) {
    switch (action.type) {
      case TOGGLE:
        return {
          ...state,
          mobile: action.payload
        };
      default:
        return state
    }
  }
};

export default setTenantSwitcherReducer
