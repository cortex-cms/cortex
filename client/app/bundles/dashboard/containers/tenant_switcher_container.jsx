import React from 'react';
import SetRailsAPIService from 'dashboard/services/rails_api_service'
import {NOT_DEFINED} from 'constants/type_constants'
import {
  UPDATE_ORGANIZATION_SCOPE,
  TOGGLE_TENANT_SWITCHER,
  TOGGLE_SIDEBAR,
  TENANT_UPDATED,
  TENANT_UPDATE_ERROR,
  SELECT_TENANT} from 'constants/tenant_switcher'
import {capitalize} from 'dashboard/helpers/formating'
import TenantNestingLookup from 'dashboard/helpers/tenant_nesting_lookup'

import EnvironmentFlag from 'components/side_bar/environment_flag'
import TenantList from 'components/side_bar/tenant_list'

const getLayoutWrapper = (serverSide) => {
  if (serverSide === true) {
    return {}
  }
  return document.getElementById('layout_wrapper')
}

class TenantSwitcherContainer extends React.PureComponent {
  constructor(props) {
    super(props);
    this.layoutWrapper = getLayoutWrapper(this.props.railsContext.serverSide)
    this.railsAPI = SetRailsAPIService(this.props.railsContext, this.props.data)
    this.tenancyLookup = TenantNestingLookup(this.props.data.tenants)
  }
  selectTenant = (tenant) => () => {
    this.updateTenant(tenant)
    this.props.dispatch({type: SELECT_TENANT, payload: tenant})
  }
  updateTenant = (tenant) => {
    const {current_user, csrf_token} = this.props.data
    const self = this;
    this.railsAPI.post('/admin_update/tenant_change', {
      current_tenant: current_user.active_tenant.id,
      requested_tenant: tenant.id,
      authenticity_token: csrf_token
    }).then(response => {
      self.props.dispatch({type: TENANT_UPDATED, payload: Object.assign({}, current_user, {active_tenant: response.data})})
      self.layoutWrapper.classList.remove('sidebar--tentant-display')

    }).catch(error => {
      self.props.dispatch({type: TENANT_UPDATE_ERROR, payload: error})
    })

  }
  organizationClicked = (org_id) => () => {
    let organizationID = this.props.data.organization_displayed === org_id ? 0 : org_id;
    this.props.dispatch({type: UPDATE_ORGANIZATION_SCOPE, payload: organizationID})
  }
  toggleTenantSwitcher = () => {
    this.props.dispatch({type: TOGGLE_TENANT_SWITCHER})
    this.layoutWrapper.className = !this.props.data.tenantListActive ? 'sidebar--tentant-display' : '';
  }
  toggleSidebar = () => {
    this.props.dispatch({type: TOGGLE_SIDEBAR})
    this.layoutWrapper.className = this.props.data.sidebarExpanded ? 'sidebar--collapsed' : '';
  }
  render() {
    const {
      environment,
      environment_abbreviated,
      current_user,
      tenant,
      selected_tenant,
      tenants,
      organization_displayed,
      tenantListActive
    } = this.props.data
    const syncedWithDB = current_user.active_tenant.id === selected_tenant.id
    return (
      <footer id="tentant_switch">
        <TenantList
        selectTenant={this.selectTenant}
        organizationClicked={this.organizationClicked}
        tenancyLookup={this.tenancyLookup}
        organization_displayed={organization_displayed}
        syncedWithDB={syncedWithDB}
        current_user={current_user}
        selected_tenant={selected_tenant}
        tenants={tenants}
        active={tenantListActive}/>
        <nav className='demo-navigation mdl-navigation'>
          <EnvironmentFlag environment={environment} environment_abbreviated={environment_abbreviated}/>
          <div onClick={this.toggleTenantSwitcher} className='mdl-navigation__link nav__item'>
            <span className='nav__item-name'>
              {syncedWithDB === true ? selected_tenant.name : 'Loading...'}
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
