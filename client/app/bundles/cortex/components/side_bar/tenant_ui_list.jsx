import React from 'react';
import {
  TOGGLE_TENANT_SWITCHER,
  TOGGLE_SIDEBAR,
  SELECT_TENANT
} from 'constants/tenant_switcher'

import {
  Spinner
} from 'cortex/elements/loaders'
import TenantPaginator from 'components/side_bar/tenant_paginator'
import List, {
  ListItem,
  ListItemIcon,
  ListItemSecondaryAction,
  ListItemText,
  ListSubheader,
} from 'material-ui/List';
import IconButton from 'material-ui/IconButton';
import BookmarkIcon from 'material-ui-icons/Bookmark';
// import BookmarkOutlineIcon from 'material-ui-icons/BookmarkOutline';
import ListIcon from 'material-ui-icons/List';
import LabelIcon from 'material-ui-icons/Label';
import LabelOutlineIcon from 'material-ui-icons/LabelOutline';
import SkipNextIcon from 'material-ui-icons/SkipNext';

const TenantItem = ({name, subdomain}, tenantClicked, tenantActive) => (
  <li key={subdomain} className="mdl-list__item" onClick={tenantClicked}>
  <i className={tenantActive ? 'material-icons tenant-active-icon' : 'hidden'}>lens</i>
   <span className="mdl-list__item-primary-content">
   <i className="material-icons mdl-list__item-icon">bookmark</i>
   {name}
  </span>
</li>
)

class TenantUIList extends React.PureComponent {
  organizationLabelClass(subTenantsDisplayed, labelActive) {
    let orgLabelClassBase = subTenantsDisplayed ? 'mdl-list__item organization--label sub-tenant-list--displayed' : 'mdl-list__item organization--label'
    orgLabelClassBase += labelActive ? ' active' : ''
    return orgLabelClassBase
  }
  renderTenants = () => {
    const { tenants, organization_displayed, selected_tenant, current_user,  selectTenant, organizationClicked, tenancyLookup } = this.props
    return tenancyLookup.organizations.map((org_id, index) => {
      let {org_tenant, sub_tenants } = tenancyLookup[org_id]
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
    const { active, syncedWithDB, tenancyLookup, activeStep, dispatch } = this.props
    const tenantListClass = active ? 'tenant__list_wrapper' : 'tenant__list_wrapper hidden'
    return (
      <div className={tenantListClass}>
        <List subheader={<li className='tenant-list__heading'>SWITCH TENANT</li>}>
           <ListItem>
             <ListItemIcon>
               <BookmarkIcon />
             </ListItemIcon>
             <ListItemText primary="Tenant" />
             <ListItemSecondaryAction>
                <IconButton aria-label="Sub Tenants">
                   <ListIcon />
                 </IconButton>
             </ListItemSecondaryAction>
           </ListItem>
           <ListItem>
             <ListItemIcon>
               <BookmarkIcon />
             </ListItemIcon>
             <ListItemText primary="Tenant" />
             <ListItemSecondaryAction>
                <IconButton aria-label="Sub Tenants">
                  <ListIcon />
                </IconButton>
             </ListItemSecondaryAction>
           </ListItem>
       </List>
         <TenantPaginator activeStep={activeStep} dispatch={dispatch}  />
         <div className={ syncedWithDB ? 'hidden' : 'loader-spinner-wrapper'}>
           <Spinner />
         </div>
      </div>
    )
  }
}

export default TenantUIList
