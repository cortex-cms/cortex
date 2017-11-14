import React from 'react'
import Paper from 'material-ui/Paper';
import List, {ListItem, ListItemText} from 'material-ui/List';
import { OPEN_STEP_FORM } from '../../constants/content_type_creator'
import StepForm from './step_form'

class WizardStep extends React.PureComponent {
  constructor(props) {
    super(props)
  }
  renderStepColumns = ({heading, elements}) => (
   <div>
     {heading}
     {elements.map((element, index) => (
       <div key={index}>
         <strong>Field:</strong>
         {this.props.fieldsLookup[element.id].name}
       </div>
     ))}

   </div>
  )
  renderStepInfo = ({name, description, heading, columns}) => (
      <Paper>
    <h1>Name: {name}</h1>
    <strong>Heading:</strong>
    <p>{heading}</p>
    <strong>Description:</strong>
    <p>{description}</p>
    {this.renderStepColumns(columns)}
    </Paper>

  )
  renderSteps = () => this.props.wizard_builder.data.steps.map((step, index) => (
    <ListItem key={index}>

        {this.renderStepInfo(step)}
    </ListItem>
  ))
  addStep = () => this.props.dispatch({ type: OPEN_STEP_FORM })
  render() {
    console.log('WizardStep this.props', this.props)
    //const { stepFormOpen } = this.props.wizard_builder
    return (
      <section className='step-container'>
      <h1>Wizard</h1>
      {/* <List>
        <ListItem><strong>Steps</strong></ListItem>
        {this.renderSteps()}
      </List>
      <Paper>
        <button className={ stepFormOpen ? 'hidden' : 'mdl-button mdl-js-button mdl-button--primary content-type-new-field-button' } onClick={ this.addStep }>
          Add Step
        </button>
      </Paper>
      <StepForm {...this.props.wizard_builder }/> */}
      </section>
    )
  }
}

export default WizardStep
