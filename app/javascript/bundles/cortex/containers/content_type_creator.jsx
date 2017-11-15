import React from 'react';
import StepBar from '../components/content_type_creator/step_bar'
import GeneralStep from '../components/content_type_creator/general_step'
import FieldsStep from '../components/content_type_creator/fields_step'
import WizardStep from '../components/content_type_creator/wizard_step'
import IndexStep from '../components/content_type_creator/index_step'
import OptionsStep from '../components/content_type_creator/options_step'
import { NEXT_STEP, PREVIOUS_STEP, DB_SYNCING, CONTENT_TYPE_SYNCED, WIZARD_SYNCED, INDEX_SYNCED, RSS_SYNCED,} from '../constants/content_type_creator'
import SetRailsAPIService from '../services/rails_api_service'
import {
  Spinner
} from '../elements/loaders'

class ContentTypeCreator extends React.Component {
  constructor(props) {
    super(props);
    this.railsAPI = SetRailsAPIService(this.props.railsContext, this.props.data)
  }

  createUpdateContentType = (path) => {
    const { session, data } = this.props

    this.railsAPI.post(path, {
      ...Object.assign({},data.content_type.contentType, {icon: document.getElementById('icon_select').value}),
      authenticity_token: session.csrf_token
    }).then(response => {
        this.props.dispatch({ type: CONTENT_TYPE_SYNCED, payload: { contentType: response.data }})
        this.handleNext()
    }).catch(error => {
      console.log('createContentType error', error )
      //self.props.dispatch({type: TENANT_UPDATE_ERROR, payload: error})
    })
    this.props.dispatch({ type: DB_SYNCING })
  }

  syncContentTypeFields = () => {
    const { session, data } = this.props

    this.railsAPI.post('/content_types/create_fields', {
      content_type_id: data.content_type.contentType.id,
      fields: data.content_type.fields,
      authenticity_token: session.csrf_token
    }).then(response => {
        this.props.dispatch({ type: CONTENT_TYPE_SYNCED, payload: { fields: response.data, fieldsLookup: response.data.reduce((lookup, field) => {
          lookup[field.id] = field;
          return lookup
        }, {}) }})
        this.handleNext()
    }).catch(error => {
      console.log('createContentType error', error )
      //self.props.dispatch({type: TENANT_UPDATE_ERROR, payload: error})
    })
    this.props.dispatch({ type: DB_SYNCING })
  }

  createUpdateWizardDecorator = (path) => {
    const { session, data } = this.props

    this.railsAPI.post(path, {
      ...{
        content_type: data.content_type.contentType,
        decorator: data.wizard_builder
      },
      authenticity_token: session.csrf_token
    }).then(response => {
        this.props.dispatch({ type: WIZARD_SYNCED, payload: response.data })
        this.handleNext()
    }).catch(error => {
      console.log('createContentType error', error )
      //self.props.dispatch({type: TENANT_UPDATE_ERROR, payload: error})
    })
    this.props.dispatch({ type: DB_SYNCING })
  }

  syncContentType = () => {
    if (this.props.data.content_type.contentType.created_at === null) {
      this.createUpdateContentType('/content_types/new_type')
    } else {
      this.createUpdateContentType('/content_types/update_type')
    }
  }

  syncWizardDecorator = () => {
    if (this.props.data.wizard_builder.created_at === null) {
      this.createUpdateWizardDecorator('/content_types/create_decorator')
    } else {
      this.createUpdateWizardDecorator('/content_types/update_decorator')
    }
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

  stepDisplay = (stepName) => this.props.data.current_step === stepName && this.props.data.dbSynced === true;
  render() {
    const { dispatch, data, session } = this.props;
    const { current_step, steps, content_type, index_builder, wizard_builder, rss_builder, field_builder, usedIcons, dbSynced } = data
    console.log('ContentTypeCreator props', this.props)

    return (
      <div >
        <StepBar current_step={current_step} steps={steps} dispatch={dispatch} />
        <div className={ dbSynced === false ? 'loader-spinner-wrapper-step' : 'hidden' }>
           <Spinner />
        </div>
        <div className={ this.stepDisplay('general') ? '' : 'hidden' }>
          <GeneralStep dispatch={dispatch} handleNext={this.syncContentType} step={steps['general']} containerContext={this} session={session} usedIcons={usedIcons} data={ content_type.contentType } />
        </div>
        <div className={ this.stepDisplay('fields') ? '' : 'hidden' }>
          <FieldsStep dispatch={dispatch} handlePrev={this.handlePrev} handleNext={this.syncContentTypeFields} field_builder={field_builder} step={steps['fields']} data={ content_type.fields } />
        </div>

        <div className={ this.stepDisplay('wizard') ? '' : 'hidden' }>
          <WizardStep dispatch={dispatch} handlePrev={this.handlePrev} handleNext={this.syncWizardDecorator} step={steps['wizard']} fieldsLookup={content_type.fieldsLookup} wizard_builder={wizard_builder} />
        </div>
        <div className={ this.stepDisplay('index') ? '' : 'hidden' }>
          <IndexStep dispatch={dispatch} handlePrev={this.handlePrev} handleNext={this.handleNext} step={steps['index']} data={index_builder} />
        </div>
        <div className={ this.stepDisplay('rss') ? '' : 'hidden' }>
          <OptionsStep dispatch={dispatch} handlePrev={this.handlePrev} step={steps['rss']} data={ rss_builder }  />
        </div>

      </div>
    );
  }
}

export default ContentTypeCreator
