import React from 'react';
import PropTypes from 'prop-types';
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
import { NOT_DEFINED } from 'constants/type_constants'

const activeListItemStyles = {
  root: {
    background: '#02a8f3',
    color: 'white',
    borderBottom: '1px solid #02a8f3'
  },
  container: {
    backgroundColor: '#02a8f3',
    color: 'white'
  },
  secondaryAction: {
    background: 'white',
    '$:hover': {
      background: '#02a8f3',
      color: 'white',
      borderBottom: '1px solid #02a8f3'
    }
  },
  label: {
    textTransform: 'capitalize',
  }
}

const listItemStyles = {}

const TenantItem = ({name, subdomain, children}, tenantClicked, tenantActive, subTenantListClick) => (
  <div className='tenant-list-item'>
  <ListItem key={subdomain} style={ tenantActive ? activeListItemStyles.root : listItemStyles } onClick={tenantClicked}>
    <Avatar alt="Remy Sharp" src='https://i.imgur.com/zQA3Cck.png' />
    <ListItemText className='organization--label' primary={name} />
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
    const { selected_tenant, current_user, parent_tenant,  selectTenant, subTenantListClicked, tenancyLookup } = this.props
    const activeTenant = selected_tenant.id;
    const listedTenantIds = parent_tenant === null ? tenancyLookup.topLevel : tenancyLookup[parent_tenant].children;

    return listedTenantIds.map((tenant_id, index) =>   TenantItem(tenancyLookup[tenant_id], selectTenant(tenancyLookup[tenant_id]), activeTenant === tenancyLookup[tenant_id].id, subTenantListClicked(tenancyLookup[tenant_id].id)) )
  }
  tenantParentHeader = ({parent_tenant, tenancyLookup, paginateBack}) => {
    let parentTenant = parent_tenant === null ? '' : tenancyLookup[parent_tenant].name;
    return (
      <div className={ parent_tenant === null ? 'hidden' : 'tenant__list-nav-header'}>
         <IconButton aria-label="Go Back" className='page-back-button' onClick={paginateBack}>
          <i className='material-icons'>chevron_left</i>
         </IconButton>
        <span>{parentTenant}</span>
      </div>
    )
  }
  render(){
    const { active, syncedWithDB } = this.props
    const tenantListClass = active ? 'tenant__list_wrapper' : 'tenant__list_wrapper hidden'
    return (
      <div className={tenantListClass}>
        <List subheader={ <li className='tenant-list__heading'> SWITCH TENANT</li> }>
          { this.tenantParentHeader(this.props) }
          { this.renderTenants() }
        </List>
         <div className={ syncedWithDB ? 'hidden' : 'loader-spinner-wrapper'}>
           <Spinner />
         </div>
      </div>
    )
  }
}

export default TenantList
