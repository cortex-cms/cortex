const usedIconsLookup = contentTypes => Object.keys(contentTypes).reduce((usedIcons, contentTypeId) => {
  usedIcons[contentTypes[contentTypeId].contentType.icon] = true;
  return usedIcons;
}, {})

const ContentTypeReducer = ({content_types, current_user, creator}) => {
  return {
    ...creator,
    content_types: content_types,
    current_step: 'general',
    dbSynced: true,
    errors: {},
    usedIcons: usedIconsLookup(content_types),
    field_builder: {
      open: false,
      form_open: false,
      expanded: null,
      validationsYaml: '',
      metadataYaml: '',
      helperText: null,
      field_edit: null,
      field_view: null
    },
    wizard_builder: {
      // assignedFields: creator.data.steps.reduce((lookUp, step) => {
      //   step.columns
      // }, {}),
      expandedStep: 0,
      openModal: null,
      ...creator.wizard
    },
    index_builder: creator.index,
    rss_builder: creator.rss,
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
        valid: true
      },
      index: {
        disabled: true,
        nextStep: 'rss',
        previousStep: 'wizard',
        valid: true
      },
      rss: {
        disabled: true,
        nextStep: null,
        previousStep: 'index',
        valid: true
      }
    }
  }
}

export default ContentTypeReducer
