angular.module('cortex.controllers.users.facets', [
  'ui.router.state',
  'ngAnimate',
  'angularBootstrapNavTree',
  'cortex.util',
  'cortex.services.cortex',
  'cortex.directives.tenantSettings'
])

  .factory('TenantTree', function () {
    return {
      selected: null
    };
  })

  .controller('UsersFacetCtrl', function ($scope, $stateParams, cortex, TenantTree) {
    $scope.data = {
      tenants: {
        hierarchy: cortex.tenants.hierarchicalIndex()
      }
    };

    $scope.selectTenant = function (tenant) {
      TenantTree.selected = tenant;
    };
  });
