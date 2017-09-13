import React from 'react';
import FieldCell from 'components/wizard/field_cell'

class Column extends React.PureComponent {
  constructor(props) {
    super(props)

  }
  renderElements = () => {
    const { contenItemFieldLookup, elements } = this.props
    return elements.filter(element => element.id).map((element, index) => {
        let fieldItemId = element.id
        return <FieldCell key={fieldItemId} field_item={element} { ...contenItemFieldLookup[fieldItemId] }/>
    })
  }
  render() {
    const { heading, grid_width, display, description } = this.props

    return (
      <div className={`mdl-cell mdl-cell--${grid_width}-col`}>
        { description && <p>{description}</p> }
        { this.renderElements() }
      </div>
    )
  }
}

export default Column
