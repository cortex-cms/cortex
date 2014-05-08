angular.module('cortex.settings', [])

.config(function($provide) {
  $provide.constant('settings', angular.copy(window.gon.settings));
})

.constant('events', {
  // Events that should be replaced with refactored states
  TENANT_HIERARCHY_CHANGE: '$tenantHierarchyChange',
  ORGANIZATIONS_CHANGE:    '$organizationsChange'
});
