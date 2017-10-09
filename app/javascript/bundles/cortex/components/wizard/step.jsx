import React from 'react';
import Column from './column'

class Step extends React.PureComponent {
  renderColumn = (column, index) => {
    return <Column key={`column_${index}` } contentItemFieldLookup={this.props.contentItemFieldLookup} {...column} />
  }
  render() {
    const { name, heading, contentItemFieldLookup, description, columns } = this.props

    return (
      <div className='mdl-grid'>
        { columns.map(this.renderColumn) }
      </div>
    )
  }
}

export default Step
