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

import {UPDATE_STEP, WIZARD_STEP_UPDATE} from '../../../constants/content_type_creator'

import Card, { CardHeader, CardMedia, CardContent, CardActions } from 'material-ui/Card';
import Collapse from 'material-ui/transitions/Collapse';
import { FormGroup, FormControlLabel } from 'material-ui/Form';
import Checkbox from 'material-ui/Checkbox';
import Paper from 'material-ui/Paper';
import Step from './step'



class StepForm extends React.PureComponent {
  constructor(props) {
    super(props)
  }
  InputLabelProps = {
    shrink: true
  }
  ReactAceOptions = {
    enableBasicAutocompletion: false,
    enableLiveAutocompletion: false,
    enableSnippets: false,
    showLineNumbers: true,
    tabSize: 2,
  }
  AceEditorProps = {
    $blockScrolling: true
  }
  handleChange = (fieldName) => (event) => {
    this.props.dispatch({
      type: UPDATE_STEP,
      payload: {
        [fieldName]: event.target.value
      }
    })
  }
  expandStep = (index) => () => this.props.dispatch({ type: WIZARD_STEP_UPDATE, payload: { expandedStep: this.props.expandedStep === index ? -1 : index }})
  openDataModal = (modalKey) => this.props.dispatch({ type: WIZARD_STEP_UPDATE, payload: { openModal: modalKey }})
  updateStep = (index, updatedStep) =>  this.props.dispatch({ type: UPDATE_STEP, payload: { [index]: updatedStep } })
  columnData = (grid_width) => ({
      data: {},
      heading: '',
      elements: [],
      grid_width: grid_width
  })
  elementData = (field_id) => ({
      id: field_id,
      data: {}
  })
  stepData = () => ({
    name: '',
    heading: '',
    description: '',
    columns: []
  })
  renderSteps = () => this.props.data.steps.map((step, index) => <Step key={index} expandStep={this.expandStep(index) } expandedStep={this.props.expandedStep} openModal={this.props.openModal} index={index} step={step} openDataModal={this.openDataModal} updateStep={this.updateStep} fieldsLookup={this.props.fieldsLookup}/>)
  render() {
    return (
      <section className='step-container'>
        { this.renderSteps() }
        <div className='mdl-grid'>
        <button className='mdl-button mdl-js-button mdl-button--primary content-type-new-field-button form-button--submission mdl-js-button mdl-button--raised mdl-button--success content-type-editor-add-button' onClick={ this.props.addStep }>
          New Step
        </button>
        </div>
      </section>
    )
  }
}

export default StepForm;
