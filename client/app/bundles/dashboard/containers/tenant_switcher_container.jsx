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

class TenantSwitcherContainer extends React.PureComponent {
  constructor(props) {
    super(props);
    this.layoutWrapper = document.getElementById('layout_wrapper')
  }
  selectTenant = (tenant) => {
    console.log('selectTenant tenant', tenant)
    this.props.dispatch({ type: SELECT_TENANT, payload: tenant })
  }
  thing() {
    $.ajax({
        url: window.location.origin + '/admin_update/tenant_change',
        type:'POST',
        dataType:'json',
        data:{
            myparam1: "First Param value",
            myparam2: "Second param value",
            authenticity_token: this.props.csrf_token
        },
        success:function(data){
          console.log('data', data)

        },
        error:function(data){
            console.log('error', data)
        }
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
  componentDidMount() {
    if(this.props.railsContext.serverSide === false) {
      this.thing()
    }
    console.log('this.props.railsContext', this.props.railsContext)
  }
  render() {
    const { environment, environment_abbreviated, tenant, selected_tenant, tenants, tenantListActive } = this.props.data

    return (
      <footer id="tentant_switch" >
        <TenantList selectTenant={this.selectTenant} selected_tenant={selected_tenant} tenants={tenants} active={tenantListActive} />
        <nav className='demo-navigation mdl-navigation'>
          <EnvironmentFlag environment={environment} environment_abbreviated={environment_abbreviated} />
          <div onClick={this.toggleTenantSwitcher} className='mdl-navigation__link nav__item'>
            <span className='nav__item-name'>
              { capitalize(selected_tenant.name) }
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
