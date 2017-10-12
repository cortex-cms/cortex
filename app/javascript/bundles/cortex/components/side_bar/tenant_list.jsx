import React from 'react';
import {
  Spinner
} from '../../elements/loaders'
import List, {
  ListItem,
  ListItemIcon,
  ListItemText,
  ListSubheader
} from 'material-ui/List';
import Avatar from 'material-ui/Avatar';
import IconButton from 'material-ui/IconButton';
import TenantAncestryList from '../../helpers/tenant_ancestry';

const TenantItem = ({ id, name, description = 'Tenant Description', children }, tenantClicked, tenantActive, subTenantListClick) => (
  <div key={id} className={tenantActive ? 'tenant-list-item active' : 'tenant-list-item'}>
    <ListItem onClick={tenantClicked}>
      <Avatar alt="Remy Sharp" src='https://i.imgur.com/zQA3Cck.png'/>
      <ListItemText className='organization--label' primary={name} secondary={description}/>
    </ListItem>
    {children &&
    <IconButton aria-label="Sub Tenants" onClick={subTenantListClick}>
      <i className='material-icons'>chevron_right</i>
    </IconButton>
    }
  </div>
);

class TenantList extends React.PureComponent {
  renderTenants = () => {
    const { activeTenant, parentTenant, selectTenant, subTenantListClicked, tenantLookupTable } = this.props;
    const listedTenantIds = parentTenant === null ? tenantLookupTable.topLevel : tenantLookupTable[parentTenant].children;

    return listedTenantIds.map((tenant_id, index) => TenantItem(tenantLookupTable[tenant_id], selectTenant(tenantLookupTable[tenant_id]), activeTenant.id === tenantLookupTable[tenant_id].id, subTenantListClicked(tenantLookupTable[tenant_id].id)))
  };

  tenantParentHeader = ({ parentTenant, tenantLookupTable, paginateBack }) => {
    return (
      <div className={parentTenant === null ? 'hidden' : 'tenant__list-nav-header'}>
        <IconButton aria-label="Go Back" className='page-back-button' onClick={paginateBack}>
          <i className='material-icons'>chevron_left</i>
        </IconButton>
        <span>{TenantAncestryList(parentTenant, tenantLookupTable).join(' < ')}</span>
      </div>
    )
  };

  render() {
    const { active, tenantSyncedWithDB } = this.props
    const tenantListClass = active ? 'tenant__list_wrapper' : 'tenant__list_wrapper hidden';
    return (
      <div className={tenantListClass}>
        <List subheader={<li className='tenant-list__heading'> SWITCH TENANT</li>}>
          {this.tenantParentHeader(this.props)}
          {this.renderTenants()}
        </List>
        <div className={tenantSyncedWithDB === true ? 'hidden' : 'loader-spinner-wrapper'}>
          <Spinner/>
        </div>
      </div>
    )
  }
}

export default TenantList
