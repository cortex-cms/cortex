import React from 'react'
import List, {ListItem, ListItemText} from 'material-ui/List';
import Select from 'material-ui/Select';
import { MenuItem } from 'material-ui/Menu';
import {Controlled as CodeMirror} from 'react-codemirror2'

const FieldTypes = {
  none: {},
  text_field_type: {
    metadata: {

    },
    validations: {

    }
  },
  boolean_field_type: {
    metadata: {},
    validations: {}
  },
  tree_field_type: {
    metadata: {},
    validations: {}
  },
  date_time_field_type: {
    metadata: {},
    validations: {}
  },
  tag_field_type: {
    metadata: {},
    validations: {}
  },
  user_field_type: {
    metadata: {},
    validations: {}
  },
  asset_field_type: {
    metadata: {},
    validations: {
      allowed_extensions: ["txt", "css", "js", "pdf", "doc", "docx", "ppt", "pptx", "csv", "xls", "xlsx", "svg", "ico", "png", "jpg", "gif", "bmp"],
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
    validations: {}
  }
}

class FieldBuilder extends React.PureComponent {
  constructor(props) {
    super(props)
  }
  renderFieldTypes = () => Object.keys(FieldTypes).map((fieldType, index) => <MenuItem key={index} value={fieldType} >{fieldType}</MenuItem>)
  render(){
    return (
      <ListItem>
        <Select
          value={'none'}
          onChange={this.handleChange('icon')}
          >
          { this.renderFieldTypes() }
        </Select>

      </ListItem>
    )
  }
}
