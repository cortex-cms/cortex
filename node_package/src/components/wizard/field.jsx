import React from 'react';
import CortexPlugin from 'cortex-plugins-core'

class Field extends React.PureComponent {
  render() {
    const {
      id,
      label,
      input,
      render_method,
      field_type,
      tooltip
    } = this.props
    if (field_type === undefined) return null

    const FieldComponent = CortexPlugin[field_type]

    return <FieldComponent {...this.props} />
  }
}

export default Field
