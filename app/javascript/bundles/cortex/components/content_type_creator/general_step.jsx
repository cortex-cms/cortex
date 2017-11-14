import React from 'react'
import Input, {InputLabel, InputAdornment} from 'material-ui/Input';
import TextField from 'material-ui/TextField';
import { FormControl, FormHelperText } from 'material-ui/Form';
import { MenuItem } from 'material-ui/Menu';
import Select from 'material-ui/Select';
import Button from 'material-ui/Button';
import {CONTENT_TYPE_UPDATED} from '../../constants/content_type_creator'

const IconsList = ['school','fiber_new','language','group_work', 'domain', 'collections', 'public', 'poll', 'whatshot', 'adb', 'apps','local_offer', 'map', 'rate_review', 'class', 'account_balance']

class GeneralStep extends React.PureComponent {
  constructor(props) {
    super(props)
    this.InputLabelProps = {
      shrink: true
    }
    const { name = '', description = '' } = props.data
    this.requiredFields = {
      name,
      description
    }
    this.IconNames = IconsList.filter(icon => props.usedIcons[icon] !== true)
  }
  checkStepValidity = () => Object.keys(this.requiredFields).reduce((bool,fieldName) => {
    if (bool === false) return bool
    bool = !!this.requiredFields[fieldName]
    return bool
  }, true)
  handleChange = fieldName => event => {
    this.requiredFields[fieldName] = event.target.value
    this.props.dispatch({
      type: CONTENT_TYPE_UPDATED,
      field: {
        [fieldName]: this.requiredFields[fieldName]
      },
      step: {
        general: Object.assign({}, this.props.step, { valid: this.checkStepValidity() })
      }
    })
  }
  renderIconList = () => this.IconNames.map((icon, index) => <MenuItem key={index} className='content-type-icon-option' value={icon}><i className='material-icons'>{icon}</i><strong>{icon}</strong></MenuItem>)
  renderTenantList = (tenants) => tenants.map((tenant, index) => <MenuItem key={index} value={tenant.id}>{tenant.name}</MenuItem>)
  render() {
    const {dispatch, data, session, handleNext, step} = this.props;
    const { name, description, tenant_id, icon } = data
    const { activeTenant, tenants } = session
    return (
      <section className='step-container'>
        <div className='mdl-grid'>
          <div className='mdl-cell mdl-cell--12-col'>
            <FormControl fullWidth className=''>
              <TextField
                required
                id='name'
                //error={}
                label='Name'
                InputLabelProps={this.InputLabelProps}
                value={ name || '' }
                onChange={this.handleChange('name')}/>
            </FormControl>
          </div>
        </div>
        <div className='mdl-grid'>
          <div className='mdl-cell mdl-cell--6-col'>
            <FormControl fullWidth className=''>
              <InputLabel htmlFor='icon'>Icon</InputLabel>
              <Select
                value={ icon === 'help' ? 'fiber_new' : icon }
                renderValue={value => <div className='content-type-icon-option'><i className='material-icons'>{value}</i><strong>{value}</strong></div>}
                onChange={this.handleChange('icon')}
                >
                { this.renderIconList() }
              </Select>
            </FormControl>
          </div>
          <div className='mdl-cell mdl-cell--6-col'>
            <FormControl fullWidth className=''>
              <InputLabel htmlFor='tenant_id'>Tenant Scope</InputLabel>
              <Select
                value={ tenant_id || activeTenant.id }
                onChange={this.handleChange('tenant_id')}
                >
                { this.renderTenantList(tenants) }
              </Select>
            </FormControl>
          </div>
        </div>
        <div className='mdl-grid'>
          <div className='mdl-cell mdl-cell--12-col'>
            <FormControl fullWidth className=''>
              <TextField
                required
                id='description'
                label='Description'
                InputLabelProps={this.InputLabelProps}
                placeholder='This Content Type is for . . . '
                helperText='Full width!'
                value={ description || '' }
                onChange={this.handleChange('description')}/>
            </FormControl>
          </div>
        </div>
        <footer className='mdl-grid'>
          <div className='mdl-cell mdl-cell--12-col content-type-step--footer'>
            <a href='/' className='mdl-button mdl-js-button mdl-button--cb mdl-js-ripple-effect'>
              Cancel
            </a>
            <button onClick={handleNext} disabled={step.valid === false} className='mdl-button form-button--submission mdl-js-button mdl-button--raised mdl-button--success mdl-js-ripple-effect'>
              Next
            </button>
          </div>
        </footer>
      </section>
    )
  }
}

export default GeneralStep
