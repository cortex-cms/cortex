import {
  FORM_VALID,
  FORM_INVALID,
  DISPLAY_VALIDATIONS
} from 'constants/wizard'

const wizardReducer = ({wizard}) => {
  const initialState = wizard
  return function reducer(state = initialState, action) {
    switch (action.type) {
      case FORM_VALID:
        return {
          ...state,
          form_valid: true
        };
      case FORM_INVALID:
        return {
          ...state,
          form_valid: false
        };
      case DISPLAY_VALIDATIONS:
        return {
          ...state,
          display_validations: true
        }
      default:
        return state
    }
  }
};

export default wizardReducer
