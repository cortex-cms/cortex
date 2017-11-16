import React from 'react'
import List, {ListItem, ListItemText} from 'material-ui/List';
import {FormControl, FormHelperText} from 'material-ui/Form';
import {MenuItem} from 'material-ui/Menu';
import Select from 'material-ui/Select';
import TextField from 'material-ui/TextField';
import Button from 'material-ui/Button';
import Input, {InputLabel, InputAdornment} from 'material-ui/Input';
import Dialog, {DialogActions, DialogContent, DialogContentText, DialogTitle} from 'material-ui/Dialog';
import Divider from 'material-ui/Divider';

import Element from './element'
import DataDialog from './data_dialog'
import Table, {TableBody, TableFooter, TableCell, TableHead, TableRow} from 'material-ui/Table';
import IconButton from 'material-ui/IconButton';
import DeleteIcon from 'material-ui-icons/Delete';
import ModeEditIcon from 'material-ui-icons/ModeEdit'

class Column extends React.PureComponent {
  constructor(props) {
    super(props)
  }
  handleChange = (fieldName) => (event) => {
    this.props.updateColumn({
      ...this.props.column,
      [fieldName]: event.target.value
    })
  }
  handleOnSave = () => {
    this.props.updateColumn({
      ...this.props.column,
      ...JSON.parse(this.data.editor.getValue())
    })

  }
  addElement = () => this.props.updateColumn({
    ...this.props.column,
    elements: this.props.column.elements.concat({id: ''})
  })
  updateElement = (elementIndex) => (updatedElement) => this.props.updateColumn({
    ...this.props.column,
    elements: Object.assign([], this.props.column.elements, {[elementIndex]: updatedElement})
  })
  renderElements = (elements) => elements.map((element, index) => <Element key={index} openModal={this.props.openModal} openDataModal={this.props.openDataModal} elementKey={[this.props.columnKey, index].join('_')} index={index} updateElement={this.updateElement(index)} element={element} fieldsLookup={this.props.fieldsLookup}/>)
  render() {
    const {openModal, columnKey} = this.props
    const {
      heading,
      elements,
      grid_width,
      ...data
    } = this.props.column;

    return (
      <TableRow>
        <TableCell>
          <FormControl fullWidth className=''>
            <TextField id='heading' label='Column Heading' InputLabelProps={this.InputLabelProps} value={heading || ''} onChange={this.handleChange('heading')}/>
          </FormControl>
        </TableCell>
        <TableCell padding='none'>
          <FormControl fullWidth className=''>
            <InputLabel htmlFor='grid_width'>Grid Width</InputLabel>
            <Select value={grid_width || 12} onChange={this.handleChange('grid_width')}>
              <MenuItem value={2}>2</MenuItem>
              <MenuItem value={3}>3</MenuItem>
              <MenuItem value={4}>4</MenuItem>
              <MenuItem value={5}>5</MenuItem>
              <MenuItem value={6}>6</MenuItem>
              <MenuItem value={7}>7</MenuItem>
              <MenuItem value={8}>8</MenuItem>
              <MenuItem value={9}>9</MenuItem>
              <MenuItem value={10}>10</MenuItem>
              <MenuItem value={12}>12</MenuItem>
            </Select>
          </FormControl>
        </TableCell>
        <TableCell padding='none'>
          <Button raised onClick={() => this.props.openDataModal(this.props.columnKey)}>Column Data</Button>
          <DataDialog open={openModal === columnKey} name='Column' handleRequestClose={() => this.props.openDataModal(null)} handleOnSave={this.handleOnSave} data={data} parentContext={this}/>
        </TableCell>

        <TableCell>
          <List>
            {this.renderElements(elements)}
          </List>
          <button className='mdl-button mdl-js-button mdl-button--primary content-type-new-field-button' onClick={this.addElement}>Add Field</button>
        </TableCell>
        <TableCell padding="none">
          <IconButton aria-label="Delete"><DeleteIcon/></IconButton>
        </TableCell>
      </TableRow>
    )
  }
}

export default Column
