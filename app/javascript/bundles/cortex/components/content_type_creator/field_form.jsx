import React from 'react'
import {FormControl, FormHelperText} from 'material-ui/Form';
import brace from 'brace';
import AceEditor from 'react-ace';
import 'brace/mode/yaml';
import 'brace/theme/solarized_dark';
import Button from 'material-ui/Button';
import TextField from 'material-ui/TextField';
import Dialog, {DialogActions, DialogContent, DialogContentText, DialogTitle, withMobileDialog} from 'material-ui/Dialog';

import {
  CLOSE_FIELD_EDITOR,
  UPDATE_YAML_FIELD,
  FIELD_NAME_ERROR,
  ADD_FIELD,
  UPDATE_FIELD_FORM,
  UPDATE_FIELD,
  EXPAND_DEFAULTS
} from '../../constants/content_type_creator'

import Card, {CardHeader, CardMedia, CardContent, CardActions} from 'material-ui/Card';
import Collapse from 'material-ui/transitions/Collapse';
import {FormGroup, FormControlLabel} from 'material-ui/Form';
import Checkbox from 'material-ui/Checkbox';

const parseYAMLValue = (data) => {
  let editorValue = ''
  try {
    editorValue = YAML.parse(data)
  } catch (e) {
    editorValue = YAML.parse(data.replace(e.snippet, ''))
  }
  return editorValue
}
class FieldForm extends React.PureComponent {
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
    tabSize: 2
  }
  AceEditorProps = {
    $blockScrolling: true
  }
  renderEditorDefaults = (dataFieldKey) => {
    const defaultValues = this.props.field_type_default[dataFieldKey]
    const dataField = this.props[dataFieldKey] || {}
    return (
      <FormGroup row>
        {Object.keys(defaultValues).map((propName, index) => (
          <FormControlLabel key={index} control={< Checkbox checked = {
            dataField[propName] !== undefined
          }
          onChange = {
            this.fieldDefaultClicked(dataFieldKey, {
              [propName]: defaultValues[propName]
            }, propName)
          }
          value = {
            propName
          } />} label={propName}/>
        ))
}
      </FormGroup>
    )
  }
  removeField = (dataField, propName) => Object.keys(dataField).reduce((cpy, key) => {
    if (key !== propName) {
      cpy[key] = dataField[key]
    }
    return cpy
  }, {})
  fieldDefaultClicked = (dataFieldKey, defaultProp, propName) => (event) => {
    console.log('dataFieldKey', dataFieldKey, 'defaultProp', defaultProp)
    const dataFieldYaml = this.props[dataFieldKey + 'Yaml']
    const dataField = Object.assign({}, this.props[dataFieldKey])
    if (dataField[propName] === undefined) {
      dataField[propName] = defaultProp
      this.props.dispatch({
        type: UPDATE_YAML_FIELD,
        payload: {
          [dataFieldKey + 'Yaml']: dataFieldYaml + YAML.stringify(defaultProp, 2)
        },
        updateFieldView: {
          [dataFieldKey]: dataField
        }
      })
    } else {
      this.props.dispatch({
        type: UPDATE_YAML_FIELD,
        payload: {
          [dataFieldKey + 'Yaml']: YAML.stringify(this.removeField(parseYAMLValue(dataFieldYaml), propName), 2)
        },
        updateFieldView: {
          [dataFieldKey]: this.removeField(dataField, propName)
        }
      })
    }
  }
  nameUnique = (name, field_edit) => this.props.fields.reduce((bool, field, i) => {
    if (bool === false || i === field_edit)
      return bool
    return field.name !== name
  }, true)
  addFieldToFieldType = () => {
    const {
      name = '',
      field_edit
    } = this.props;
    if (name.length < 2) {
      this.props.dispatch({type: FIELD_NAME_ERROR, payload: 'Field Name Must Be Atleast 2 Characters'})
      return
    }
    if (this.nameUnique(name, field_edit) === false) {
      this.props.dispatch({type: FIELD_NAME_ERROR, payload: 'Field Name Already Taken'})
      return
    }
    this.props.dispatch({type: ADD_FIELD})
  }
  updateYamlField = (fieldDataKey) => (newValue) => this.props.dispatch({
    type: UPDATE_YAML_FIELD,
    payload: {
      [fieldDataKey + 'Yaml']: newValue
    },
    updateFieldView: {}
  })
  expandDefaults = (dataKey) => () => this.props.dispatch({type: EXPAND_DEFAULTS, payload: dataKey})
  closeFormModal = () => this.props.dispatch({type: CLOSE_FIELD_EDITOR})
  handleRequestClose = () => this.props.dispatch({type: CLOSE_FIELD_EDITOR})
  handleChange = (fieldName) => (event) => {
    this.props.dispatch({
      type: UPDATE_FIELD,
      payload: {
        [fieldName]: event.target.value
      }
    })
  }
  treeFieldValues = () => {
    const {metadata} = this.props;
    if (!metadata) {
      return {
        tree_array: [
          {
            example: []
          }, {
            example2: []
          }
        ]
      }
    }
    return {
      tree_array: metadata.allowed_values.data.tree_array.map((treeValue) => {
        return {
          [treeValue.node.name]: []
        }
      })
    }
  }
  treeFieldTypeProps = (treeField) => treeField
    ? {
      split: 2,
      value: ['', this.props.metadataYaml]
    }
    : this.props.metadataYaml;
  onTreeFieldChange = (event) => {}
  treeFieldType = () => (
    <div className='mdl-cell mdl-cell--12-col'>
      <Card className='content-type-editor'>
        <strong>Tree Fields:</strong>
        <FormControl fullWidth className=''>
          <AceEditor mode='yaml' theme="solarized_dark" width='100%' highlightActiveLine={true} value={YAML.stringify(this.treeFieldValues(), 2)} onChange={this.updateYamlField()} name='tree_values' setOptions={this.ReactAceOptions} editorProps={this.AceEditorProps}/>
        </FormControl>
      </Card>
    </div>
  )

  render() {
    const {
      dispatch,
      name,
      validations,
      metadata,
      form_open,
      fullScreen,
      field_type,
      expanded,
      helperText,
      field_type_default,
      validationsYaml,
      metadataYaml
    } = this.props;
    return (
      <Dialog open={form_open} fullWidth={true} maxWidth={'100%'} onRequestClose={this.handleRequestClose}>
        <DialogTitle>New Field</DialogTitle>
        <DialogContent>
          <div className='mdl-cell mdl-cell--12-col'>
            <FormControl fullWidth className=''>
              <TextField required id='name' error={helperText !== null} helperText={helperText} label='Field Name' InputLabelProps={this.InputLabelProps} value={name || ''} onChange={this.handleChange('name')}/>
            </FormControl>
          </div>
          <div className='mdl-grid'>
            <div className='mdl-cell mdl-cell--6-col'>
              <Card className='content-type-editor'>
                <strong>Validations:</strong>
                {
                Object.keys(field_type_default.validations).length > 0 &&
                  <span className='side-buttons' onClick={this.expandDefaults('validations')}>
                    Common Defaults:
                    <i className='material-icons'>{expanded === 'validations' ? 'expand_less': 'expand_more'}</i>
                  </span>
                }
                {
                Object.keys(field_type_default.validations).length > 0 &&
                  <Collapse in={expanded === 'validations'} transitionDuration="auto">
                    {this.renderEditorDefaults('validations')}
                  </Collapse>
                }
                <FormControl fullWidth className=''>
                  <AceEditor mode='yaml' theme="solarized_dark" width='100%' highlightActiveLine={true} width='100%' ref={input => this.validations = input} value={validationsYaml} onChange={this.updateYamlField('validations')} onInput={(e) => {
                    console.log('onInput', e)
                  }} name='validations' setOptions={this.ReactAceOptions} editorProps={this.AceEditorProps}/>
                </FormControl>
              </Card>
            </div>
            <div className='mdl-cell mdl-cell--6-col'>
              <Card className='content-type-editor'>
                <strong>Metadata:</strong>
                {
                Object.keys(field_type_default.metadata).length > 0 &&
                  <span className='side-buttons' onClick={this.expandDefaults('metadata')}>
                    Common Defaults:
                    <i className='material-icons'>{expanded === 'metadata' ? 'expand_less' : 'expand_more'}</i>
                  </span>
                }
                {
                Object.keys(field_type_default.metadata).length > 0 &&
                 <Collapse in={expanded === 'metadata'} transitionDuration="auto">
                  {this.renderEditorDefaults('metadata')}
                 </Collapse>
                }
                <FormControl fullWidth className=''>
                  <AceEditor mode='yaml' theme="solarized_dark" width='100%' highlightActiveLine={true} value={metadataYaml} onChange={this.updateYamlField('metadata')} name='metadata' setOptions={this.ReactAceOptions} editorProps={this.AceEditorProps}/>
                </FormControl>
              </Card>
            </div>
          </div>
        </DialogContent>
        <DialogActions>
          <Button onClick={this.closeFormModal} color='primary'>
            Cancel
          </Button>
          <Button raised color='primary' onClick={this.addFieldToFieldType} color='primary'>
            Add
          </Button>
        </DialogActions>
      </Dialog>
    )
  }
}

export default FieldForm;
