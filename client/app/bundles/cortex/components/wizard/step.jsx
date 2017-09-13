import React from 'react';
import Column from 'components/wizard/column'

class Step extends React.PureComponent {
  renderColumn = (column, index) => {
    return <Column key={`column_${index}` } contenItemFieldLookup={this.props.contenItemFieldLookup} {...column} />
  }
  render() {
    const { name, heading, contenItemFieldLookup, description, columns } = this.props

    return (
      <div className='mdl-grid'>
        { columns.map(this.renderColumn) }
      </div>
    )
  }
}

export default Step
