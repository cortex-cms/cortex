import React from 'react'
import List, {ListItem, ListItemText} from 'material-ui/List';
import Select from 'material-ui/Select';
import {MenuItem} from 'material-ui/Menu';
import Button from 'material-ui/Button';
import FieldForm from './field_form';
import Card, {CardHeader, CardMedia, CardContent, CardActions} from 'material-ui/Card';
import {FormControl, FormHelperText} from 'material-ui/Form';
import FieldTypes from './field_types'

class FieldBuilder extends React.PureComponent {
  constructor(props) {
    super(props)
  }
  updateFieldBuilder = () => {}
  renderFieldTypes = () => Object.keys(FieldTypes).map((fieldType, index) => <MenuItem key={index} value={fieldType}>{fieldType}</MenuItem>)

  render() {
    const {field_builder, dispatch, fields} = this.props;
    const {
      field_view = {},
      form_open,
      open,
      field_edit,
      helperText
    } = field_builder
    return (
      <div className={field_builder.open ? '' : 'hidden'}>
        <div className={form_open
          ? 'hidden'
          : 'mdl-grid content-type-add-field'}>
          <div className='mdl-cell node'>
            <strong>Select Field Type:</strong>
          </div>
          <div className='mdl-cell mdl-cell--8-col'>
            <FormControl fullWidth className=''>
              <Select value={field_view
                ? field_view.field_type
                : 'text_field_type'} onChange={this.props.changeFieldType}>
                {this.renderFieldTypes()}
              </Select>
            </FormControl>
          </div>
          <div className='mdl-cell node buttons-column'>
            <Button onClick={this.props.closeAddField}>
              Cancel
            </Button>
            <Button color="primary" raised onClick={this.props.openFieldForm}>
              Add
            </Button>
          </div>
        </div>
        <FieldForm dispatch={dispatch} fields={fields} {...field_builder} field_type_default={field_view ? FieldTypes[field_view.field_type] : FieldTypes.text_field_type} {...field_view}/>
      </div>
    )
  }
}

export default FieldBuilder;
