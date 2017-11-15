import React from 'react'
import Paper from 'material-ui/Paper';
import List, {ListItem, ListItemText} from 'material-ui/List';
import { ADD_WIZARD_STEP } from '../../constants/content_type_creator'
import StepForm from './step_elements/step_form'

class WizardStep extends React.PureComponent {
  constructor(props) {
    super(props)
  }

  addStep = () => this.props.dispatch({ type: ADD_WIZARD_STEP })
  render() {
    console.log('WizardStep this.props', this.props)
    const { fieldsLookup, wizard_builder, dispatch } = this.props
    const { stepFormOpen } = wizard_builder
    return (
      <section className='step-container'>
      <h1>Steps</h1>
      <StepForm {...this.props.wizard_builder } dispatch={dispatch} fieldsLookup={fieldsLookup} addStep={this.addStep}/>
      </section>
    )
  }
}

export default WizardStep
