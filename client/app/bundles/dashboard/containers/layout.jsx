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
    this.crsf_token = ReactOnRails.authenticityToken()
  }
  render() {
    const { data, dispatch } = this.props
    return (
      <section>
        <TenantSwitcherContainer dispatch={dispatch} crsf_token={this.crsf_token} railsContext={data.railsContext} data={data.session}/>
      </section>
    )
  }
}

export default connect(select)(Layout);
