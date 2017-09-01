import React from 'react';
import { NOT_DEFINED } from 'constants/type_constants'
import {
  TOGGLE_TENANT_SWITCHER,
  TOGGLE_SIDEBAR,
  SELECT_TENANT
} from 'constants/tenant_switcher'
import {
  capitalize
} from 'dashboard/helpers/formating'
import EnvironmentFlag from 'components/side_bar/environment_flag'
import TenantList from 'components/side_bar/tenant_list'

function select(state) {
  return { data: state };
}

class TenantSwitcherContainer extends React.PureComponent {
  constructor(props) {
    super(props);
  }
  selectTenant = (tenant) => {
    this.props.dispatch({ type: SELECT_TENANT, payload: tenant })
  }
  toggleTenantSwitcher = () => {
      this.props.dispatch({ type: TOGGLE_TENANT_SWITCHER })
      document.body.className = !this.props.data.tenantListActive ? 'sidebar--tentant-display' : '';
  }
  toggleSidebar = () => {
    this.props.dispatch({ type: TOGGLE_SIDEBAR })
    document.body.className = this.props.data.sidebarExpanded ? 'sidebar--collapsed' : '';
  }
  render() {
    console.log('TenantSwitcherContainer this.props', this.props)
    const { environment, environment_abbreviated, tenant, selected_tenant, tenants, tenantListActive } = this.props.data

    return (
      <footer id="tentant_switch" >
        <TenantList tenantClicked={this.selectTenant} selected_tenant={selected_tenant} tenants={tenants} active={tenantListActive} />
        <nav className='demo-navigation mdl-navigation'>
          <EnvironmentFlag environment={environment} environment_abbreviated={environment_abbreviated} />
          <div onClick={this.toggleTenantSwitcher} className='mdl-navigation__link nav__item'>
            <span className='nav__item-name'>
              { capitalize(tenant.name) }
            </span>
            <i className='material-icons' role="presentation">device_hub</i>
          </div>
        </nav>
        <div className='sidebar__toggle-button' onClick={this.toggleSidebar} id='sidebar__toggle-button'></div>
      </footer>
    )
  }
}

export default TenantSwitcherContainer
