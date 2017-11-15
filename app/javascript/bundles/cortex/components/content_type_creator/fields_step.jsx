import React from 'react'
import List, {ListItem, ListItemText} from 'material-ui/List';
import Divider from 'material-ui/Divider';
import FieldBuilder from './field_builder'
import {
  ADD_FIELD,
  OPEN_FIELD_FORM,
  EDIT_FIELD,
  DELETE_FIELD,
  CLOSE_ADD_FIELD,
  OPEN_FIELD_EDITOR,
  UPDATE_FIELD
} from '../../constants/content_type_creator'
import Table, {TableBody, TableFooter, TableCell, TableHead, TableRow} from 'material-ui/Table';
import Paper from 'material-ui/Paper';
import IconButton from 'material-ui/IconButton';
import DeleteIcon from 'material-ui-icons/Delete';
import ModeEditIcon from 'material-ui-icons/ModeEdit'

class FieldsStep extends React.PureComponent {
  constructor(props) {
    super(props)
  }
  addField = () => this.props.dispatch({type: OPEN_FIELD_FORM})
  openFieldForm = () => this.props.dispatch({type: OPEN_FIELD_EDITOR})
  closeAddField = () => this.props.dispatch({type: CLOSE_ADD_FIELD})
  changeFieldType = (e) => this.props.dispatch({
    type: UPDATE_FIELD,
    payload: {
      field_type: e.target.value
    }
  })
  deleteField = (field) => () => this.props.dispatch({type: DELETE_FIELD, payload: field})
  editField = (field, index) => () => this.props.dispatch({type: EDIT_FIELD, field: field, index: index})
  renderFields = () => this.props.data.map((field, index) => {
    const {name, field_type, validations, metadata} = field;
    return (
      <TableRow key={index}>
        <TableCell>
          <b>{name}</b>
        </TableCell>
        <TableCell>
          <b>{field_type}</b>
        </TableCell>
        <TableCell>{validations ? Object.keys(validations).join(', ') : 'None'}</TableCell>
        <TableCell>{metadata ? Object.keys(metadata).join(', ') : 'None'}</TableCell>
        <TableCell>
          <IconButton aria-label="Delete" onClick={this.deleteField(field)}><DeleteIcon/></IconButton>
          <IconButton color="primary" aria-label="edit" onClick={this.editField(field, index)}>
            <ModeEditIcon/>
          </IconButton>
        </TableCell>
      </TableRow>
    )
  })

  render() {
    const {
      field_builder,
      dispatch,
      data,
      handleNext,
      handlePrev,
      step
    } = this.props
    return (
      <section className='step-container'>
        <h1>Field Builder</h1>
        <Paper>
          <Table className=''>
            <TableHead>
              <TableCell>Field Name</TableCell>
              <TableCell>Field Type</TableCell>
              <TableCell>Field Validations</TableCell>
              <TableCell>Field Metadata</TableCell>
              <TableCell></TableCell>
            </TableHead>
            <TableBody>
              {this.renderFields()}
            </TableBody>
            <TableFooter></TableFooter>
          </Table>
        </Paper>
        <Paper>
          <button className={field_builder.open
            ? 'hidden'
            : 'mdl-button mdl-js-button mdl-button--primary content-type-new-field-button'} onClick={this.addField}>
            New Field
          </button>
          <FieldBuilder field_builder={field_builder} fields={data} closeAddField={this.closeAddField} dispatch={dispatch} openFieldForm={this.openFieldForm} changeFieldType={this.changeFieldType}/>
        </Paper>
        <footer className='mdl-grid'>
          <div className='mdl-cell mdl-cell--12-col content-type-step--footer'>
            <a href='/' className='mdl-button mdl-js-button mdl-button--cb mdl-js-ripple-effect'>
              Cancel
            </a>
            <button onClick={handlePrev} className='mdl-button form-button--submission mdl-js-button mdl-button--raised mdl-button--alert mdl-js-ripple-effect'>
              Back
            </button>
            <button onClick={handleNext} disabled={step.valid === false} className='mdl-button form-button--submission mdl-js-button mdl-button--raised mdl-button--success mdl-js-ripple-effect'>
              Next
            </button>
          </div>
        </footer>
      </section>
    )
  }
}

export default FieldsStep
