import React from 'react'
import {FormControl, FormHelperText} from 'material-ui/Form';
import brace from 'brace';
import AceEditor from 'react-ace';
import 'brace/mode/yaml';
import 'brace/theme/solarized_dark';
import Button from 'material-ui/Button';
import TextField from 'material-ui/TextField';
import Dialog, {
  DialogActions,
  DialogContent,
  DialogContentText,
  DialogTitle,
  withMobileDialog
} from 'material-ui/Dialog';
import List, {ListItem, ListItemText} from 'material-ui/List';

import { FormGroup, FormControlLabel } from 'material-ui/Form';
import Checkbox from 'material-ui/Checkbox';
import Paper from 'material-ui/Paper';
import Column from './column'

import Card, { CardHeader, CardMedia, CardContent, CardActions } from 'material-ui/Card';
import Collapse from 'material-ui/transitions/Collapse';
import Table, { TableBody, TableFooter, TableCell, TableHead, TableRow } from 'material-ui/Table';

class Step extends React.PureComponent {
  constructor(props) {
    super(props)
  }
  InputLabelProps = {
    shrink: true
  }
  handleChange = (fieldName) => (event) => {
    this.props.updateStep(this.props.index, {
        ...this.props.step,
        [fieldName]: event.target.value
      })
  }
  addColumn = () => this.props.updateStep(this.props.index, {
      ...this.props.step,
      columns: this.props.step.columns.concat({ heading: '', elements: [], grid_width: 12 })
    })
  updateColumn = (columnIndex) => (updatedColumn) => this.props.updateStep(this.props.index, {
      ...this.props.step,
      columns: Object.assign([], this.props.step.columns, { [columnIndex]: updatedColumn })
    })
  renderColumns = (columns) => columns.map((column, index) => <Column key={index} openModal={this.props.openModal} openDataModal={this.props.openDataModal} columnKey={[this.props.index, index].join('_') } index={ index} updateColumn={this.updateColumn(index)} column={column} fieldsLookup={this.props.fieldsLookup}/>)
  render() {
    console.log('Step this.props', this.props)
    const { index, expandedStep, expandStep } = this.props
    const { name, heading, description, columns } = this.props.step;
    return (
      <Card>
        <CardHeader
          title={`Step ${index + 1}`}
          subheader={
            <span className='side-buttons' onClick={expandStep} >
              Expand Step:
              <i className='material-icons' >{expandedStep === index ? 'expand_less' : 'expand_more'}</i>
            </span>
          }
        />

      <Collapse in={expandedStep === index} transitionDuration="auto" unmountOnExit>
        <CardContent>
        <div className='mdl-grid'>
        <div className='mdl-cell mdl-cell--4-col'>
          <FormControl fullWidth className=''>
            <TextField
              required
              id='name'
              label='Step Name'
              value={name || ''}
              onChange={this.handleChange('name')}/>
          </FormControl>
        </div>
        <div className='mdl-cell mdl-cell--8-col'>
          <FormControl fullWidth className=''>
            <TextField
              id='heading'
              label='Step Heading'
              value={heading || ''}
              onChange={this.handleChange('heading')}/>
          </FormControl>
        </div>
        <div className='mdl-cell mdl-cell--12-col'>
          <FormControl fullWidth className=''>
            <TextField
              id='description'
              label='Step Description'
              value={description || ''}
              onChange={this.handleChange('description')}/>
          </FormControl>
        </div>
          <div className='mdl-cell mdl-cell--12-col'>
            <b>Columns:</b>
          </div>
        </div>
        <Table>
          <TableHead>
            <TableCell>Heading</TableCell>
            <TableCell padding="none">Grid Width</TableCell>
            <TableCell padding="none">Column Data</TableCell>
            <TableCell>Field Elements</TableCell>

            <TableCell padding="none"></TableCell>
          </TableHead>
          <TableBody>
          {this.renderColumns(columns)}
        </TableBody>
        </Table>
        <div className='mdl-cell mdl-cell--12-col'>
          <button className='mdl-button form-button--submission mdl-js-button mdl-button--raised mdl-button--success mdl-js-ripple-effect content-type-new-field-button content-type-editor-add-button' onClick={this.addColumn}>Add Column</button>
        </div>
        </CardContent>
    </Collapse>
      </Card>
    )
  }
}

export default Step;
