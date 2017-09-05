import React from 'react';
import axios from 'axios';
import { NOT_DEFINED } from 'constants/type_constants'
import {
  TOGGLE_TENANT_SWITCHER,
  TOGGLE_SIDEBAR,
  TENANT_UPDATED,
  TENANT_UPDATE_ERROR,
  SELECT_TENANT
} from 'constants/tenant_switcher'
import {
  capitalize
} from 'dashboard/helpers/formating'

import EnvironmentFlag from 'components/side_bar/environment_flag'
import TenantList from 'components/side_bar/tenant_list'

const getLayoutWrapper = (serverSide) => {
  if(serverSide === true) {
    return {}
  }
  return document.getElementById('layout_wrapper')
}

class TenantSwitcherContainer extends React.PureComponent {
  constructor(props) {
    super(props);
    this.layoutWrapper = getLayoutWrapper(this.props.railsContext.serverSide)
    axios.defaults.headers.common['X-CSRF-Token'] = this.props.csrf_token
    axios.defaults.headers.common['Accept'] = 'application/json'
  }
  selectTenant = (tenant) => {
    console.log('selectTenant tenant', tenant)
    this.updateTenant(tenant)
    this.props.dispatch({ type: SELECT_TENANT, payload: tenant })
  }
  updateTenant = (tenant) => {
    const { current_user, csrf_token } = this.props.data
    const self = this;
    axios.post(window.location.origin + '/admin_update/tenant_change',{
            current_tenant: current_user.active_tenant.id,
            requested_tenant: tenant.id,
            authenticity_token: csrf_token
        }).then(response => {
          console.log('response', response)
          self.props.dispatch({ type: TENANT_UPDATED, payload: Object.assign({}, current_user, {active_tenant: response.data }) })

        }).catch(error => {
            console.log('error', error)
            self.props.dispatch({ type: TENANT_UPDATE_ERROR, payload: error })
        })

  }
  toggleTenantSwitcher = () => {
      this.props.dispatch({ type: TOGGLE_TENANT_SWITCHER })
      this.layoutWrapper.className = !this.props.data.tenantListActive ? 'sidebar--tentant-display' : '';
  }
  toggleSidebar = () => {
    this.props.dispatch({ type: TOGGLE_SIDEBAR })
    this.layoutWrapper.className = this.props.data.sidebarExpanded ?  'sidebar--collapsed' : '';
  }
  render() {
    console.log('this.props', this.props)
    const { environment, environment_abbreviated, current_user, tenant, selected_tenant, tenants, tenantListActive } = this.props.data
    const syncedWithDB = current_user.active_tenant.id === selected_tenant.id
    return (
      <footer id="tentant_switch" >
        <TenantList selectTenant={this.selectTenant} syncedWithDB={syncedWithDB} current_user={current_user} selected_tenant={selected_tenant} tenants={tenants} active={tenantListActive} />
        <nav className='demo-navigation mdl-navigation'>
          <EnvironmentFlag environment={environment} environment_abbreviated={environment_abbreviated} />
          <div onClick={this.toggleTenantSwitcher} className='mdl-navigation__link nav__item'>
            <span className='nav__item-name'>
              { syncedWithDB === true ? selected_tenant.name : 'Loading...'}
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
