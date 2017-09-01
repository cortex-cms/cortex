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
    const { data, dispatch } = this.props
    return (
      <section>
        <TenantSwitcherContainer dispatch={dispatch} data={data.session}/>
      </section>
    )
  }
}

export default connect(select)(Layout);
