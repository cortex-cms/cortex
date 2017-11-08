import {
  NEXT_STEP,
  PREVIOUS_STEP,
  FORM_VALID,
  FORM_INVALID,
  STEP_CLICKED,
  CONTENT_TYPE_UPDATED,
  DISPLAY_VALIDATIONS
} from '../constants/content_type_creator'

const ContentTypeCreator = {
  current_step: 'general',
  field_builder: null,
  steps: {
    general: {
      disabled: false,
      nextStep: 'fields',
      previousStep: null,
      valid: false
    },
    fields: {
      disabled: true,
      nextStep: 'wizard',
      previousStep: 'general',
      valid: false
    },
    wizard: {
      disabled: true,
      nextStep: 'index',
      previousStep: 'fields',
      valid: false
    },
    index: {
      disabled: true,
      nextStep: 'options',
      previousStep: 'wizard',
      valid: false
    },
    options: {
      disabled: true,
      nextStep: null,
      previousStep: 'index',
      valid: false
    }
  }
}


const contentTypeCreatorReducer = ({creator}) => {
  const initialState = Object.assign({}, ContentTypeCreator ,creator)
  return function reducer(state = initialState, action) {
    switch (action.type) {
      case STEP_CLICKED:
        return {
          ...state,
          current_step: action.payload
        }
      case PREVIOUS_STEP:
        return {
          ...state,
          current_step: action.current_step
        }
      case NEXT_STEP:
        return {
          ...state,
          current_step: action.current_step,
          steps: {
            ...state.steps,
            ...action.nextStep
          }
        }
      case CONTENT_TYPE_UPDATED:
        return {
          ...state,
          content_type: {
            ...state.content_type,
            contentType: {
              ...state.content_type.contentType,
              ...action.field
            }
          },
          steps: {
            ...state.steps,
            ...action.step
          }
        }
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

export default contentTypeCreatorReducer
