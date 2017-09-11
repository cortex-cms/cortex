import {
  WIZARD
} from 'constants/wizard'

const setWizardReducer = ({wizard}) => {
  const initialState = wizard
  return function reducer(state = initialState, action) {
    switch (action.type) {
      case WIZARD:
        return {
          ...state,
          selected_tenant: action.payload
        };
      default:
        return state
    }
  }
};

export default setWizardReducer
