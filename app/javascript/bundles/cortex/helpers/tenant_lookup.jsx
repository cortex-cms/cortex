import { NOT_DEFINED } from '../constants/type_constants'

const TenantIndex = (tenants) => tenants.reduce((lookup, tenant, i) => {
  lookup[tenant.id] = tenant
  return lookup;
}, {topLevel: []})

const TenantLookup = (tenants) => {

   return tenants.reduce((lookup, tenant, i) => {
      if(tenant.parent_id === null) {
        lookup.topLevel.push(tenant.id);
        return lookup;
      }
      if(lookup[tenant.parent_id].children === NOT_DEFINED) {
        lookup[tenant.parent_id].children = []
      }
      lookup[tenant.parent_id].children.push(tenant.id)
      return lookup;
   }, TenantIndex(tenants))
}

export default TenantLookup
