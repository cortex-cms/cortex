import React from 'react';
import { NOT_DEFINED } from 'constants/type_constants'
import Step from 'components/wizard/step'

class WizardContainer extends React.PureComponent {
  constructor(props){
    super(props)
    this.contentItemFieldLookup = props.data.fields.reduce((lookup, field) => {
      lookup[field.id] = field
      return lookup
    }, {})
  }
  renderStep = (step, index) => {
    return <Step key={`step_${index}`} contentItemFieldLookup={this.contentItemFieldLookup} {...step} />
  }
  render() {
    const { steps, fields, content_item, content_type } = this.props.data

    return (
      <div>
        {steps.map(this.renderStep)}
      </div>
    )
  }
}

export default WizardContainer
