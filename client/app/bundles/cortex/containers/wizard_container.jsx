import React from 'react';
import { NOT_DEFINED } from 'constants/type_constants'
import Step from 'components/wizard/step'

class WizardContainer extends React.PureComponent {
  renderStep = (step, index) => {
    return <Step key={`step_${index}`} {...step} />
  }
  render() {
    const { steps, content_item, content_type } = this.props.data
    return (
      <div className='mdl-cell'>
        {steps.map(this.renderStep)}
      </div>
    )
  }
}

export default WizardContainer
