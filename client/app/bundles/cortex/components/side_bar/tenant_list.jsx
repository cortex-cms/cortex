import React from 'react';
import {
  Spinner
} from 'cortex/elements/loaders'
import List, {
  ListItem,
  ListItemIcon,
  ListItemText,
  ListSubheader
} from 'material-ui/List';
import Avatar from 'material-ui/Avatar';
import IconButton from 'material-ui/IconButton';
import { NOT_DEFINED } from 'constants/type_constants';
import TenantAncestryList from  'cortex/helpers/tenant_ancestry';

const activeListItemStyles = {
  root: {
    background: '#02a8f3',
    color: 'white',
    borderBottom: '1px solid #02a8f3'
  },
  container: {
    backgroundColor: '#02a8f3',
    color: 'white'
  }
}

const listItemStyles = {}

const TenantItem = ({id, name, description = 'Tenant Description', children}, tenantClicked, tenantActive, subTenantListClick) => (
  <div key={id} className='tenant-list-item'>
  <ListItem style={ tenantActive ? activeListItemStyles.root : listItemStyles } onClick={tenantClicked}>
  <ListItem onClick={tenantClicked}>
    <Avatar alt="Remy Sharp" src='https://i.imgur.com/zQA3Cck.png' />
    <ListItemText className='organization--label' primary={name}  secondary={description} />
  </ListItem>
  { children &&
     <IconButton aria-label="Sub Tenants" onClick={subTenantListClick}>
         <i className='material-icons'>chevron_right</i>
      </IconButton>
  }
  </div>
)

class TenantList extends React.PureComponent {
  renderTenants = () => {
    const { selectedTenant, currentUser, parentTenant,  selectTenant, subTenantListClicked, tenantLookupTable } = this.props
    const activeTenant = selectedTenant.id;
    const listedTenantIds = parentTenant === null ? tenantLookupTable.topLevel : tenantLookupTable[parentTenant].children;

    return listedTenantIds.map((tenant_id, index) =>   TenantItem(tenantLookupTable[tenant_id], selectTenant(tenantLookupTable[tenant_id]), activeTenant === tenantLookupTable[tenant_id].id, subTenantListClicked(tenantLookupTable[tenant_id].id)) )
  }
  tenantParentHeader = ({parentTenant, tenantLookupTable, paginateBack}) => {
    return (
      <div className={ parentTenant === null ? 'hidden' : 'tenant__list-nav-header'}>
         <IconButton aria-label="Go Back" className='page-back-button' onClick={paginateBack}>
          <i className='material-icons'>chevron_left</i>
         </IconButton>
        <span>{TenantAncestryList(parentTenant, tenantLookupTable).join(' < ')}</span>
      </div>
    )
  }
  render(){
    const { active, tenantSyncedWithDB } = this.props
    const tenantListClass = active ? 'tenant__list_wrapper' : 'tenant__list_wrapper hidden'
    return (
      <div className={tenantListClass}>
        <List subheader={ <li className='tenant-list__heading'> SWITCH TENANT</li> }>
          { this.tenantParentHeader(this.props) }
          { this.renderTenants() }
        </List>
        <div className={ tenantSyncedWithDB === true ? 'hidden' : 'loader-spinner-wrapper'}>
          <Spinner />
        </div>
      </div>
    )
  }
}

export default TenantList
