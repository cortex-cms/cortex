angular.module('cortex.controllers.users.edit', [
  'ui.router.state',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.controllers.users.facets'
])

.controller('UsersEditCtrl', function($scope, $timeout, $state, $anchorScroll, flash, cortex, TenantTree) {
  $scope.data = $scope.data || {};
  $scope.data.user = new cortex.users();
  $scope.data.selectedTenant = TenantTree.selected;

  $scope.saveUser = function() {
    $scope.data.user.tenant_id = $scope.data.selectedTenant.id;
    $scope.data.user.$save().then(
      function() {
        $state.go('^.facets.grid');
        flash.info = 'Saved user information';
      },
      function(res) {
        $anchorScroll();
        if (res.status === 403) {
          flash.error = "Chosen password is invalid";
        } else {
          flash.error = 'Error while saving user information';
        }
      }
    );
  };
});
