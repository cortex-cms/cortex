import React from 'react'
import Paper from 'material-ui/Paper';
import List, {ListItem, ListItemText} from 'material-ui/List';
import {ADD_WIZARD_STEP} from '../../constants/content_type_creator'
import StepForm from './step_elements/step_form'

class WizardStep extends React.PureComponent {
  constructor(props) {
    super(props)
  }

  addStep = () => this.props.dispatch({type: ADD_WIZARD_STEP})
  render() {
    console.log('WizardStep this.props', this.props)
    const {
      fieldsLookup,
      wizard_builder,
      dispatch,
      step,
      handlePrev,
      handleNext
    } = this.props
    const {stepFormOpen} = wizard_builder
    return (
      <section className='step-container'>
        <h1>Steps</h1>
        <StepForm {...this.props.wizard_builder } dispatch={dispatch} fieldsLookup={fieldsLookup} addStep={this.addStep}/>
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

export default WizardStep
