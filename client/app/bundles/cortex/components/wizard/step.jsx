import React from 'react';
import Column from 'components/wizard/column'

class Step extends React.PureComponent {
  renderColumn = (column, index) => {
    return <Column key={`column_${index}` } {...column} />
  }
  render() {
    const { name, heading, description, columns } = this.props
    console.log('Step props', this.props)
    return (
      <div className='mdl-grid'>
        { columns.map(this.renderColumn) }
      </div>
    )
  }
}

export default Step
