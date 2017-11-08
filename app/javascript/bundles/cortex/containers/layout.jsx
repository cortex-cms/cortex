import React from 'react';
import { connect } from 'react-redux';

import TenantSwitcherContainer from './tenant_switcher_container';
import WizardContainer from './wizard_container';
import ContentTypeCreator from './content_type_creator';

function select(state) {
  return { data: state };
}

class Layout extends React.PureComponent {
  constructor(props) {
    super(props)
  }
  render() {
    const { data, dispatch, temporary_render } = this.props
    console.log('Layout Props', this.props)
    return (
      <section>
      {/* remove temporary_render once containers are all connected */}
      { temporary_render === 'TenantSwitcher' &&
        <TenantSwitcherContainer dispatch={dispatch} railsContext={data.railsContext} data={data.session}/>
      }
      { temporary_render === 'ContentTypeCreator' &&
        <ContentTypeCreator dispatch={dispatch} railsContext={data.railsContext} session={data.session} data={data.creator}/>
      }
      { temporary_render === 'Wizard' &&
        <WizardContainer dispatch={dispatch} railsContext={data.railsContext} data={data.wizard}/>
      }
      </section>
    )
  }
}

export default connect(select)(Layout);
