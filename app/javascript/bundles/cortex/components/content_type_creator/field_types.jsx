const FieldTypes = {
  text_field_type: {
    metadata: {
      parse_widgets: true
    },
    validations: {
      length: { minimum: 50, maximum: 500 },
      presence: true,
      uniqueness: true
    }
  },
  boolean_field_type: {
    metadata: {},
    validations: {}
  },
  date_time_field_type: {
    metadata: {},
    validations: {
      presence: true
    }
  },
  tag_field_type: {
    metadata: {},
    validations: {}
  },
  user_field_type: {
    metadata: {},
    validations: {
      presence: true
    }
  },
  asset_field_type: {
    metadata: {},
    validations: {
      allowed_extensions: [
        "txt",
        "css",
        "js",
        "pdf",
        "doc",
        "docx",
        "ppt",
        "pptx",
        "csv",
        "xls",
        "xlsx",
        "svg",
        "ico",
        "png",
        "jpg",
        "gif",
        "bmp"
      ],
      max_size: 52428800,
      presence: true
    }
  },
  content_item_field_type: {
    metadata: {},
    validations: {}
  },
  author_field_type: {
    metadata: {},
    validations: {
      presence: true
    }
  }
}

export default FieldTypes;
