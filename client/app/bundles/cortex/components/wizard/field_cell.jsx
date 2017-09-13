import React from 'react';
import CortexPlugin from 'cortex-plugins-core'

class FieldCell extends React.PureComponent {
  render(){
    const {
      id,
      label,
      input,
      render_method,
      field_type,
      tooltip
    } = this.props
    if (field_type === undefined) return null

    const Field = CortexPlugin[field_type]
    // console.log('this.props', this.props)
    return <Field {...this.props} />
  }
}

export default FieldCell
