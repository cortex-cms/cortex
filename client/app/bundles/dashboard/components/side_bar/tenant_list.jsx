import React from 'react';
import {
  TOGGLE_TENANT_SWITCHER,
  TOGGLE_SIDEBAR,
  SELECT_TENANT
} from 'constants/tenant_switcher'

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
    const { tenants, selectTenant } = this.props

    return tenants.map((tenant) => TenantItem(tenant, () => selectTenant(tenant)) )
  }
  render(){
    const { active } = this.props
    const tenantListClass = active ? 'tenant__list_wrapper' : 'tenant__list_wrapper hidden'
    return (
      <div className={tenantListClass}>
         <ul className="demo-list-icon mdl-list">
          {this.renderTenants()}
         </ul>
      </div>
    )
  }
}

export default TenantList
