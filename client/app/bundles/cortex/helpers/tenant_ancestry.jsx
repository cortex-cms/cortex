const ParentLookup = (parent_id, tenancyLookup, nameList) => {
  if (parent_id === null) {
    return nameList
  }
  let tenant = tenancyLookup[parent_id];
  nameList.unshift(tenant.name)
  return ParentLookup(tenant.parent_id,tenancyLookup, nameList)
}

const TenantAncestryList = (parent_tenant, tenancyLookup) => {
  return ParentLookup(parent_tenant, tenancyLookup, [])
}

export default TenantAncestryList;
