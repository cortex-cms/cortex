const usedIconsLookup = contentTypes => Object.keys(contentTypes).reduce((usedIcons, contentTypeId) => {
  usedIcons[contentTypes[contentTypeId].contentType.icon] = true;
  return usedIcons;
}, {} )

const ContentTypeReducer = ({ content_types, current_user, creator }) => {
  return {
    ...creator,
    content_types: content_types,
    current_step: 'general',
    field_builder: {
      usedIcons: usedIconsLookup(content_types),
      open: false,
      form_open: false,
      expanded: null,
      validationsYaml: '',
      metadataYaml: '',
      helperText: null,
      field_edit: null,
      field_view: null
    },
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
}

export default ContentTypeReducer
