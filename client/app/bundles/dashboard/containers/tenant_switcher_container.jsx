import React from 'react';
import { NOT_DEFINED } from 'constants/type_constants'
import {
  TOGGLE
} from 'constants/tenant_switcher'


function select(state) {
  return { data: state };
}

class TenantSwitcherContainer extends React.PureComponent {
  constructor(props) {
    super(props);
  }

  render() {
    const { data } = this.props
    return (
      <footer>
        <nav className='demo-navigation mdl-navigation'>
          <div className='mdl-navigation__link nav__item'>
          <span className='nav__item-name'>
            Cortex
          </span>
          <i className='material-icons' role="presentation">device_hub</i>

          </div>
        </nav>
        <div className='sidebar__toggle-button' id='sidebar__toggle-button'></div>
      </footer>
    )
  }
}

export default TenantSwitcherContainer
