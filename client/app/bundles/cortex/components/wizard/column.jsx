import React from 'react';

class Column extends React.PureComponent {
  render() {
    const { heading, grid_width, display, elements, description } = this.props
    console.log('Column props', this.props)
    return (
      <div className={`mdl-cell mdl-cell--#{grid_width}-col`}>
        { description && <p>{description}</p> }
      </div>
    )
  }
}

export default Column
