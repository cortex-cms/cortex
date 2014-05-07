var module = angular.module('cortex.settings', []);

module.config(function($provide) {
  $provide.constant('settings', angular.copy(window.gon.settings));
});

module.constant('events', {
  // Events that should be replaced with refactored states
  TENANT_HIERARCHY_CHANGE: '$tenantHierarchyChange',
  ORGANIZATIONS_CHANGE:    '$organizationsChange'
})
