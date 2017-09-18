import {
  PLACEHOLDER_ACTION_TYPE
} from 'constants/wizard'

const setWizardReducer = ({wizard}) => {
  const initialState = wizard
  return function reducer(state = initialState, action) {
    switch (action.type) {
      case PLACEHOLDER_ACTION_TYPE:
        return {
          ...state,
          form_valid: action.payload
        };
      default:
        return state
    }
  }
};

export default setWizardReducer
