import React from 'react';
import SetRailsAPIService from 'cortex/services/rails_api_service'
import { NOT_DEFINED } from 'constants/type_constants'
import {
  TOGGLE_TENANT_SWITCHER,
  TOGGLE_SIDEBAR,
  TENANT_UPDATED,
  SUBLIST_CLICKED,
  PAGINATE_BACK,
  TENANT_UPDATE_ERROR,
  SELECT_TENANT
} from 'constants/tenant_switcher'
import Avatar from 'material-ui/Avatar';
import TenantLookup from 'cortex/helpers/tenant_lookup'

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
    this.tenantLookupTable = TenantLookup(this.props.data.tenants)
  }
  selectTenant = (tenant) => () => {
    this.updateTenant(tenant)
    this.props.dispatch({type: SELECT_TENANT, payload: tenant})
  }
  updateTenant = (tenant) => {
    const { currentUser, csrf_token } = this.props.data
    const self = this;
    this.railsAPI.post('/admin_update/tenant_change', {
      current_tenant: currentUser.active_tenant.id,
      requested_tenant: tenant.id,
      authenticity_token: csrf_token
    }).then(response => {
      self.props.dispatch({type: TENANT_UPDATED, payload: Object.assign({}, currentUser, {active_tenant: response.data})})
      self.layoutWrapper.classList.remove('sidebar--tentant-display')

    }).catch(error => {
      self.props.dispatch({type: TENANT_UPDATE_ERROR, payload: error})
    })

  }
  paginateBack = () => {
    const { parentTenant } = this.props.data;
    this.props.dispatch({type: PAGINATE_BACK, payload: this.tenantLookupTable[parentTenant].parent_id})
  }
  subTenantListClicked = (parent_id) => () => {
    this.props.dispatch({type: SUBLIST_CLICKED, payload: parent_id})
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
      currentUser,
      selectedTenant,
      parentTenant,
      tenantSyncedWithDB,
      tenantListActive
    } = this.props.data

    return (
      <footer id="tentant_switch">
        <TenantList
        selectTenant={this.selectTenant}
        subTenantListClicked={this.subTenantListClicked}
        paginateBack={this.paginateBack}
        tenantLookupTable={this.tenantLookupTable}
        tenantSyncedWithDB={tenantSyncedWithDB}
        currentUser={currentUser}
        selectedTenant={selectedTenant}
        parentTenant={parentTenant}
        active={tenantListActive}/>

        <nav className='demo-navigation mdl-navigation'>
          <EnvironmentFlag environment={environment} environment_abbreviated={environment_abbreviated}/>
          <div onClick={this.toggleTenantSwitcher} className='mdl-navigation__link nav__item'>
            <div className={tenantSyncedWithDB === true ? 'sidebar-tenant-icon' : 'hidden'} >
              <Avatar alt="Remy Sharp"   src='https://i.imgur.com/zQA3Cck.png' />
            </div>
            <span className='nav__item-name nav__item-name--footer'>
              {tenantSyncedWithDB === true ? selectedTenant.name : 'Loading...'}
            </span>
            <i className='material-icons tenant-toggle' role="presentation">{tenantListActive === true ? 'expand_less' : 'expand_more' }</i>
          </div>
        </nav>
        <div className='sidebar__toggle-button' onClick={this.toggleSidebar} id='sidebar__toggle-button'></div>
      </footer>
    )
  }
}

export default TenantSwitcherContainer
