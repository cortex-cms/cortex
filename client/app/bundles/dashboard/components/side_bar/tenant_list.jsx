import React from 'react';
import {
  TOGGLE_TENANT_SWITCHER,
  TOGGLE_SIDEBAR,
  SELECT_TENANT
} from 'constants/tenant_switcher'
import {
  Spinner
} from 'dashboard/elements/loaders'

const TenantItem = ({name, subdomain}, tenantClicked, tenantActive) => (
  <li key={subdomain} className="mdl-list__item" onClick={tenantClicked}>
  <i className={tenantActive ? 'material-icons tenant-active-icon' : 'hidden'}>lens</i>
   <span className="mdl-list__item-primary-content">
   <i className="material-icons mdl-list__item-icon">bookmark</i>
   {name}
  </span>
</li>
)

class TenantList extends React.PureComponent {
  organizationLabelClass(subTenantsDisplayed, labelActive) {
    let orgLabelClassBase = subTenantsDisplayed ? 'mdl-list__item organization--label sub-tenant-list--displayed' : 'mdl-list__item organization--label'
    orgLabelClassBase += labelActive ? ' active' : ''
    return orgLabelClassBase
  }
  renderTenants = () => {
    const { tenants, organization_displayed, selected_tenant, current_user,  selectTenant, organizationClicked, OrganizationLookup } = this.props
    return OrganizationLookup.organizations.map((org_id, index) => {
      let {org_tenant, sub_tenants } = OrganizationLookup[org_id]
      const organizationActive = (current_user.active_tenant.id === org_tenant.id || current_user.active_tenant.parent_id === org_tenant.id)
      return (
        <ul key={org_tenant.subdomain + '_org'}>
         <li role="button" className={ this.organizationLabelClass((organization_displayed === org_tenant.id), organizationActive ) } tabIndex={index} >
          <i className={current_user.active_tenant.id === org_tenant.id ? 'material-icons tenant-active-icon' : 'hidden'}>lens</i>
          <span onClick={selectTenant(org_tenant)} className="mdl-list__item-primary-content">
           <i className="material-icons mdl-list__item-icon">book</i>
           <strong>{org_tenant.name}</strong>
          </span>
          <i onClick={organizationClicked(org_id)} className="material-icons sub-tenant--toggle sub-tenant--toggle">keyboard_arrow_down</i>
         </li>
         <ul className={ organization_displayed === org_tenant.id ? "demo-list-icon mdl-list sub-tenant--list" : "hidden"}>
          { sub_tenants.map((tenant) => TenantItem(tenant, selectTenant(tenant), current_user.active_tenant.id === tenant.id ) )}
         </ul>
        </ul>
      )

    })
  }
  render(){
    const { active, syncedWithDB, OrganizationLookup } = this.props
    const tenantListClass = active ? 'tenant__list_wrapper' : 'tenant__list_wrapper hidden'
    return (
      <div className={tenantListClass}>
         <ul className="demo-list-icon mdl-list">
          <li className='tenant-list--heading'>
            SWITCH TENANT
          </li>
          {this.renderTenants()}
         </ul>
         <div className={ syncedWithDB ? 'hidden' : 'loader-spinner-wrapper'}>
           <Spinner />
         </div>
      </div>
    )
  }
}

export default TenantList
