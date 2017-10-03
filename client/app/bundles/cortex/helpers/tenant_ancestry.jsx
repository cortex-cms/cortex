const ParentLookup = (parent_id, tenantLookupTable, nameList) => {
  if (parent_id === null) {
    return nameList
  }
  let tenant = tenantLookupTable[parent_id];
  nameList.unshift(tenant.name)
  return ParentLookup(tenant.parent_id, tenantLookupTable, nameList)
}

const TenantAncestryList = (parentTenant, tenantLookupTable) => {
  return ParentLookup(parentTenant, tenantLookupTable, [])
}

export default TenantAncestryList;
