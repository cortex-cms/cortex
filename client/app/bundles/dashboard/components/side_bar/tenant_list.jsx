import React from 'react';
import {
  TOGGLE_TENANT_SWITCHER,
  TOGGLE_SIDEBAR,
  SELECT_TENANT
} from 'constants/tenant_switcher'
import {
  Spinner
} from 'dashboard/elements/loaders'

const TenantItem = ({name, subdomain}, tenantClicked) => (
  <li key={subdomain} className="mdl-list__item" onClick={tenantClicked}>
   <span className="mdl-list__item-primary-content">
   <i className="material-icons mdl-list__item-icon">bookmark</i>
   {name}
  </span>
</li>
)

class TenantList extends React.PureComponent {
  renderTenants = () => {
    const { tenants, organization_displayed, selected_tenant,  selectTenant, organizationClicked, OrganizationLookup } = this.props
    return OrganizationLookup.organizations.map((org_id, index) => {
      let {org_tenant, sub_tenants } = OrganizationLookup[org_id]
      return (
        <span key={org_tenant.subdomain + '_org'}>
         <li role="button" className={ "mdl-list__item organization--label" + (organization_displayed === org_tenant.id ? ' active' : '' ) } tabIndex={index} onClick={organizationClicked(org_id)}><strong>{org_tenant.name}</strong></li>
         <ul className={ organization_displayed === org_tenant.id ? "demo-list-icon mdl-list" : "hidden"}>
          { sub_tenants.map((tenant) => TenantItem(tenant, () => selectTenant(tenant)) )}
         </ul>
        </span>
      )

    })
  }
  render(){
    const { active, syncedWithDB, OrganizationLookup } = this.props
    console.log('OrganizationLookup', OrganizationLookup)
    const tenantListClass = active ? 'tenant__list_wrapper' : 'tenant__list_wrapper hidden'
    return (
      <div className={tenantListClass}>
         <ul className="demo-list-icon mdl-list">
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
