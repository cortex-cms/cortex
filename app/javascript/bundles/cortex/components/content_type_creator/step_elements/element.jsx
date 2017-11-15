import React from 'react'
import List, {ListItem, ListItemText} from 'material-ui/List';
import { FormControl, FormHelperText } from 'material-ui/Form';
import Input, {InputLabel, InputAdornment} from 'material-ui/Input';
import { MenuItem } from 'material-ui/Menu';
import Select from 'material-ui/Select';
import TextField from 'material-ui/TextField';
import Button from 'material-ui/Button';
import Dialog, {
  DialogActions,
  DialogContent,
  DialogContentText,
  DialogTitle,
} from 'material-ui/Dialog';
import DataDialog from './data_dialog'

class Element extends React.PureComponent {
  constructor(props) {
    super(props)
  }
  handleChange = (fieldName) => (event) => {
    this.props.updateElement({
      ...this.props.element,
      [fieldName]: event.target.value
    })
  }
  handleOnSave = () => {
    console.log('handleOnSave this.data', this.data);
    console.log('handleOnSave this.data.getSession().getValue()', this.data.editor.getValue());
    this.props.updateElement({
        ...this.props.element,
        ...JSON.parse(this.data.editor.getValue())
      })

  }
  renderAvailableFields = (fieldsLookup) => Object.keys(fieldsLookup).map((fieldId, index) => <MenuItem key={index} value={fieldId}>{fieldsLookup[fieldId].name}</MenuItem>)
  render(){
    const { element,index ,fieldsLookup, openModal, elementKey } = this.props
    const { id, ...data } = element
    return (
      <li className='mdl-grid'>
        <div className='mdl-cell mdl-cell--8-col content-type-step-cell'>
        <FormControl fullWidth className=''>
          <InputLabel htmlFor='grid_width'>Field</InputLabel>
          <Select
            value={ id || '' }
            onChange={this.handleChange('id')}
            >
            { this.renderAvailableFields(fieldsLookup) }
          </Select>
        </FormControl>
      </div>
      <div className='mdl-cell mdl-cell--4-col content-type-step-cell'>
        <Button color='primary' onClick={ () => this.props.openDataModal(elementKey)}>Data</Button>
      </div>
        <DataDialog open={openModal === elementKey} name='Field' handleRequestClose={() => this.props.openDataModal(null)} handleOnSave={this.handleOnSave} data={data} handleOnChange={this.handleChange('data')} parentContext={this}  />
      </li>
    )
  }
}

export default Element;
