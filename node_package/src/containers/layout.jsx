import React from 'react';
import {connect} from 'react-redux';

import TenantSwitcherContainer from './tenant_switcher_container';
import WizardContainer from './wizard_container';

function select(state) {
  return {data: state};
}

class Layout extends React.PureComponent {
  constructor(props) {
    super(props)
  }

  render() {
    const {data, dispatch, temporary_render} = this.props;

    return (
      <span>
      {/* remove temporary_render once containers are all connected */}
        {temporary_render === 'TenantSwitcher' &&
        <TenantSwitcherContainer dispatch={dispatch} railsContext={data.railsContext} data={data.session}/>
        }
        {temporary_render === 'Wizard' &&
        <WizardContainer dispatch={dispatch} railsContext={data.railsContext} data={data.wizard}/>
        }
      </span>
    )
  }
}

export default connect(select)(Layout);
