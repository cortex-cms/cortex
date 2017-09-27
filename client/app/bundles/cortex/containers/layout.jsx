import React from 'react';
import ReactOnRails from 'react-on-rails';
import { connect } from 'react-redux';
import { NOT_DEFINED } from 'constants/type_constants';

import TenantSwitcherContainer from 'containers/tenant_switcher_container';
import WizardContainer from 'containers/wizard_container';

function select(state) {
  return { data: state };
}

class Layout extends React.PureComponent {
  constructor(props) {
    super(props)
  }
  render() {
    const { data, dispatch, temporary_render } = this.props

    return (
      <section>
      {/* remove temporary_render once containers are all connected */}
      { temporary_render === 'TenantSwitcher' &&
        <TenantSwitcherContainer dispatch={dispatch} railsContext={data.railsContext} data={data.session}/>
      }
      { temporary_render === 'Wizard' &&
        <WizardContainer dispatch={dispatch} railsContext={data.railsContext} data={data.wizard}/>
      }
      </section>
    )
  }
}

export default connect(select)(Layout);
