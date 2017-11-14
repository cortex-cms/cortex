import React from 'react';
import {
  STEP_CLICKED
} from '../../constants/content_type_creator'

class StepBar extends React.PureComponent {
  constructor(props) {
    super(props)
  }
  stepClicked = (step_key) => () => {
    if( this.props.steps[step_key].disabled === false ) {
      this.props.dispatch({ type: STEP_CLICKED, payload: step_key })
    }
  }
  stepState({ current_step, steps }, step_key){
    if (current_step === step_key) {
      return 'mdl-stepper-step active-step editable-step'
    }
    if (steps[step_key].disabled === true) {
      return 'mdl-stepper-step'
    }
    if (steps[step_key].valid === true) {
      return 'mdl-stepper-step active-step step-done'
    }
    return 'mdl-stepper-step active-step'
  }
  render(){
    return (
    <div className='content-type-creator-steps'>
      <div onClick={this.stepClicked('general')} className={this.stepState(this.props, 'general')}>
        <div className='mdl-stepper-circle'><span>1</span></div>
        <div className='mdl-stepper-title'>General</div>
        <div className='mdl-stepper-bar-left'></div>
        <div className='mdl-stepper-bar-right'></div>
      </div>
      <div onClick={this.stepClicked('fields')} className={this.stepState(this.props, 'fields')}>
        <div className='mdl-stepper-circle'><span>2</span></div>
        <div className='mdl-stepper-title'>Fields</div>
        <div className='mdl-stepper-bar-left'></div>
        <div className='mdl-stepper-bar-right'></div>
      </div>
      <div onClick={this.stepClicked('wizard')} className={this.stepState(this.props, 'wizard')}>
        <div className='mdl-stepper-circle'><span>3</span></div>
        <div className='mdl-stepper-title'>Wizard</div>
        <div className='mdl-stepper-bar-left'></div>
        <div className='mdl-stepper-bar-right'></div>
      </div>
      <div onClick={this.stepClicked('index')} className={this.stepState(this.props, 'index')}>
        <div className='mdl-stepper-circle'><span>4</span></div>
        <div className='mdl-stepper-title'>Index</div>
        <div className='mdl-stepper-bar-left'></div>
        <div className='mdl-stepper-bar-right'></div>
      </div>
      <div onClick={this.stepClicked('rss')} className={this.stepState(this.props, 'rss')}>
        <div className='mdl-stepper-circle'><span>5</span></div>
        <div className='mdl-stepper-title'>Rss</div>
        <div className='mdl-stepper-bar-left'></div>
        <div className='mdl-stepper-bar-right'></div>
      </div>
    </div>
    )
  }
}

export default StepBar;
