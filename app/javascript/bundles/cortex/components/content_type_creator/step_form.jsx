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

import {UPDATE_STEP} from '../../constants/content_type_creator'

import Card, { CardHeader, CardMedia, CardContent, CardActions } from 'material-ui/Card';
import Collapse from 'material-ui/transitions/Collapse';
import { FormGroup, FormControlLabel } from 'material-ui/Form';
import Checkbox from 'material-ui/Checkbox';

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
  expandNewColumn = () => this.props.dispatch({ type: UPDATE_STEP, payload: { columnFormOpen: true }})
  render() {
    const { stepFormOpen, helperText, step_view } = this.props
    const { name, description, heading, columnFormOpen } = step_view
    return (
      <Dialog
        open={stepFormOpen}
        fullWidth={true}
        maxWidth={'100%'}
        onRequestClose={this.handleRequestClose}>
        <DialogTitle>New Step</DialogTitle>
        <DialogContent>
          <div className='mdl-cell mdl-cell--12-col'>
            <FormControl fullWidth className=''>
              <TextField
                required
                id='name'
                error={ helperText !== null }
                helperText={ helperText }
                label='Step Name'
                InputLabelProps={this.InputLabelProps}
                value={name || ''}
                onChange={this.handleChange('name')}/>
            </FormControl>
          </div>
          <div className='mdl-grid'>
            <div className='mdl-cell mdl-cell--6-col'>
              <FormControl fullWidth className=''>
                <TextField
                  required
                  id='heading'
                  label='Step Heading'
                  InputLabelProps={this.InputLabelProps}
                  value={heading || ''}
                  onChange={this.handleChange('heading')}/>
              </FormControl>
            </div>
            <div className='mdl-cell mdl-cell--6-col'>
              <FormControl fullWidth className=''>
                <TextField
                  required
                  id='description'
                  label='Step Description'
                  InputLabelProps={this.InputLabelProps}
                  value={description || ''}
                  onChange={this.handleChange('description')}/>
              </FormControl>
            </div>
          </div>
          <List>
            <Collapse in={ columnFormOpen } transitionDuration="auto">

            </Collapse>
            <button className={ columnFormOpen ? 'hidden' : 'mdl-button mdl-js-button mdl-button--primary content-type-new-field-button' } onClick={ this.expandNewColumn }>
              Add Column
            </button>
            <button className={ columnFormOpen ? 'mdl-button mdl-js-button mdl-button--primary content-type-new-field-button' : 'hidden' } onClick={ this.expandNewColumn }>
              Save
            </button>
          </List>
      </DialogContent>
    </Dialog>
    )
  }
}

export default StepForm;
