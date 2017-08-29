import {
  TOGGLE
} from 'constants/tenant_switcher'

const setTenantSwitcherReducer = ({tenant, current_user}) => {
  const initialState = { tenant_switcher: { tenant, current_user } }
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
