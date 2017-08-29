import React from 'react';
import { NOT_DEFINED } from 'constants/type_constants'
import {
  TOGGLE
} from 'constants/tenant_switcher'
import {
  capitalize
} from 'dashboard/helpers/formating'

function select(state) {
  return { data: state };
}

class TenantSwitcherContainer extends React.PureComponent {
  constructor(props) {
    super(props);
  }
  render() {
    console.log('TenantSwitcherContainer this.props', this.props)
    const { environment, environment_abbreviated, tenant } = this.props.data
    const envClass = `mdl-navigation__link nav__item environment environment--${environment}`
    return (
      <footer>
        <nav className='demo-navigation mdl-navigation'>
          <div className={envClass}>
            <div className='environment__full'>
              {environment}
            </div>
            <div className='environment__abbreviated'>
              {environment_abbreviated}
            </div>
          </div>
          <div className='mdl-navigation__link nav__item'>
          <span className='nav__item-name'>
            { capitalize(tenant.name) }
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
