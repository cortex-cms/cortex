const TenantOrganizationLookup = (tenants) => {
  return tenants.reduce((lookup, tenant, i) => {
    if (tenant.parent_id === null){
      lookup.organizations.push(tenant.id)
      if (lookup[tenant.id]) {
        lookup[tenant.id].org_tenant = tenant
      } else {
        lookup[tenant.id] = {
          org_tenant: tenant,
          sub_tenants: []
        }
      }
    } else {
      if(lookup[tenant.parent_id]) {
        lookup[tenant.parent_id].sub_tenants.push(tenant)
      } else {
        lookup[tenant.parent_id] = {
          org_tenant: null,
          sub_tenants: [tenant]
        }
      }
    }
    return lookup
  }, {organizations: []})
}

export default TenantOrganizationLookup
