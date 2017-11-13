import React from 'react';
import StepBar from '../components/content_type_creator/step_bar'
import GeneralStep from '../components/content_type_creator/general_step'
import FieldsStep from '../components/content_type_creator/fields_step'
import WizardStep from '../components/content_type_creator/wizard_step'
import IndexStep from '../components/content_type_creator/index_step'
import OptionsStep from '../components/content_type_creator/options_step'
import {NEXT_STEP,PREVIOUS_STEP} from '../constants/content_type_creator'

class ContentTypeCreator extends React.Component {
  constructor(props) {
    super(props);
  }

  handleNext = () => {
    const {current_step, steps} = this.props.data;
    const currentStep = steps[current_step];
    if (currentStep.valid === true) {
      this.props.dispatch({ type: NEXT_STEP, current_step: currentStep.nextStep, nextStep: { [currentStep.nextStep]: Object.assign({}, steps[currentStep.nextStep], {disabled: false})  }});
    }
  }

  handlePrev = () => {
    const {current_step, steps} = this.props.data;
    const currentStep = steps[current_step];
    this.props.dispatch({ type: PREVIOUS_STEP, current_step: currentStep.previousStep });
  }
  render() {
    const { dispatch, data, session } = this.props;
    const { current_step, steps, content_type, index_builder, wizard_builder, rss_builder, field_builder } = data
    console.log('ContentTypeCreator props', this.props)

    return (
      <div >
        <StepBar current_step={current_step} steps={steps} dispatch={dispatch} />
        <div className={ current_step === 'general' ? '' : 'hidden' }>
          <GeneralStep dispatch={dispatch} handleNext={this.handleNext} step={steps['general']} session={session} data={ content_type.contentType } />
        </div>
        <div className={ current_step === 'fields' ? '' : 'hidden' }>
          <FieldsStep dispatch={dispatch} handlePrev={this.handlePrev} handleNext={this.handleNext} field_builder={field_builder} step={steps['fields']} data={ content_type.fields } />
        </div>

        <div className={ current_step === 'wizard' ? '' : 'hidden' }>
          <WizardStep dispatch={dispatch} handlePrev={this.handlePrev} handleNext={this.handleNext} step={steps['wizard']} fieldsLookup={content_type.fields.reduce((lookup,field) => {
            lookup[field.id] = field;
            return field
          },{})} wizard_builder={wizard_builder} />
        </div>
        <div className={ current_step === 'index' ? '' : 'hidden' }>
          <IndexStep dispatch={dispatch} handlePrev={this.handlePrev} handleNext={this.handleNext} step={steps['index']} data={index_builder} />
        </div>
        <div className={ current_step === 'rss' ? '' : 'hidden' }>
          <OptionsStep dispatch={dispatch} handlePrev={this.handlePrev} step={steps['rss']} data={ rss_builder }  />
        </div>

      </div>
    );
  }
}

export default ContentTypeCreator
