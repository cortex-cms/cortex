import {
  UPDATE_FIELD,
  ADD_FIELD,
  NEXT_STEP,
  PREVIOUS_STEP,
  FORM_VALID,
  FORM_INVALID,
  STEP_CLICKED,
  CONTENT_TYPE_UPDATED,
  DISPLAY_VALIDATIONS,
  OPEN_FIELD_EDITOR,
  CLOSE_FIELD_EDITOR,
  CLOSE_ADD_FIELD,
  EXPAND_DEFAULTS,
  UPDATE_FIELD_FORM,
  OPEN_FIELD_FORM,
  FIELD_NAME_ERROR,
  EDIT_FIELD,
  UPDATE_YAML_FIELD,
  DELETE_FIELD
} from '../constants/content_type_creator'
import ContentTypeReducer from '../helpers/content_type_reducer'

const getYamlData = (data) => data === null ? '' : YAML.stringify(data, 2);

const parseYAMLValue = (data) => {
  let editorValue = ''
  try {
    editorValue = YAML.parse(data)
  }
  catch (e) {
    editorValue = YAML.parse(data.replace(e.snippet, ''))
  }
  return editorValue
}

const contentTypeCreatorReducer = (props) => {
  const { creator } = props;
  const initialState = ContentTypeReducer(props)
  return function reducer(state = initialState, action) {
    switch (action.type) {
      case OPEN_FIELD_FORM:
        return {
          ...state,
          field_builder: {
            ...state.field_builder,
            open: true,
            form_open: false,
            expanded: null,
            helperText: null,
            validationsYaml: '',
            metadataYaml: '',
            field_edit: state.content_type.fields.length,
            field_view: {
              field_type: "text_field_type",
              name: '',
              content_type_id: state.content_type.contentType.id,
              metadata: null,
              validations: null
            }
          }
        }
      case EDIT_FIELD:
        return {
          ...state,
          field_builder: {
            ...state.field_builder,
            open: false,
            form_open: true,
            expanded: null,
            helperText: null,
            validationsYaml: getYamlData(action.field.validations),
            metadataYaml: getYamlData(action.field.metadata),
            field_edit: action.index,
            field_view: action.field
          }
      }
      case DELETE_FIELD:
        return {
          ...state,
          content_type: {
            ...state.content_type,
            fields: state.content_type.fields.filter((field) => field.name !== action.payload.name)
          }
        }
      case ADD_FIELD:
        return {
          ...state,
          steps: {
            ...state.steps,
            [state.current_step]: {
              ...state.steps[state.current_step],
              valid: true
            }
          },
          content_type: {
            ...state.content_type,
            fields: Object.assign([], state.content_type.fields, {[state.field_builder.field_edit]: Object.assign({},state.field_builder.field_view, { validations: parseYAMLValue(state.field_builder.validationsYaml) , metadata: parseYAMLValue(state.field_builder.metadataYaml) }) })
          },
          field_builder: {
            ...state.field_builder,
            open: false,
            form_open: false,
            expanded: null,
            helperText: null,
            field_view: {
              field_type: "text_field_type",
              name: '',
              content_type_id: state.content_type.contentType.id,
              metadata: null,
              validations: null
            }
          }
        }
      case EXPAND_DEFAULTS:
        return {
          ...state,
          field_builder: {
            ...state.field_builder,
            expanded: state.field_builder.expanded === action.payload ? null : action.payload
          }
        }
      case UPDATE_FIELD:
        return {
          ...state,
          field_builder: {
            ...state.field_builder,
            helperText: null,
            open: true,
            field_view: {
              ...state.field_builder.field_view,
              ...action.payload
            }
          }

        }
      case UPDATE_YAML_FIELD:
        return {
          ...state,
          field_builder: {
            ...state.field_builder,
            ...action.payload,
            field_view: {
              ...state.field_builder.field_view,
              ...action.updateFieldView
            }
          }
        }
      case UPDATE_FIELD_FORM:
        return {
          ...state,
          field_builder: {
            ...state.field_builder,
            open: true,
            field_view: {
              ...state.field_builder.field_view,
              ...action.payload
            }
          }
        }
      case FIELD_NAME_ERROR:
        return {
          ...state,
          field_builder: {
            ...state.field_builder,
            helperText: action.payload
          }
        }
      case CLOSE_ADD_FIELD:
        return {
          ...state,
          field_builder: {
            ...state.field_builder,
            open: false,
            form_open: false
          }

        }
      case OPEN_FIELD_EDITOR:
        return {
          ...state,
          field_builder: {
            ...state.field_builder,
            field_edit: state.content_type.fields.length,
            open: true,
            form_open: true
          }

        }
      case CLOSE_FIELD_EDITOR:
        return {
          ...state,
          field_builder: {
            ...state.field_builder,
            open: false,
            form_open: false
          }

        }
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
