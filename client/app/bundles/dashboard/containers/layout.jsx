import React from 'react';
import ReactOnRails from 'react-on-rails';
import { connect } from 'react-redux';
import { NOT_DEFINED } from 'constants/type_constants'

import TenantSwitcherContainer from 'containers/tenant_switcher_container'


function select(state) {
  return { data: state };
}

class Layout extends React.PureComponent {
  constructor(props) {
    super(props)
  }
  render() {
    const { data } = this.props
    console.log('this.props', this.props)
    return (
      <section>
        <TenantSwitcherContainer data={data.tenant_switcher}/>
      </section>
    )
  }
}

export default connect(select)(Layout);
