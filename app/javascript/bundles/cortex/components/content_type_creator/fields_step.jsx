import React from 'react'
import List, {ListItem, ListItemText} from 'material-ui/List';
import Divider from 'material-ui/Divider';

class FieldsStep extends React.PureComponent {
  constructor(props) {
    super(props)
  }
  renderFields = () => this.props.data.map((field, index) => <ListItem key={index}></ListItem>)
  render() {
    return (
      <section className='step-container'>
        <h1>Field Builder</h1>
        <List className=''>
          {this.renderFields()}
          <Divider/>
          <ListItem button>
            <strong>New Field</strong>
          </ListItem>
        </List>
      </section>
    )
  }
}

export default FieldsStep
