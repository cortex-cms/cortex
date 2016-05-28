angular.module('cortex.controllers.users.new', [
  'ui.router.state',
  'angular-flash.service',
  'validation.match',
  'cortex.controllers.users.facets'
])

.controller('UsersNewCtrl', function($scope, $timeout, $state, $anchorScroll, flash, user, TenantTree) {
  $scope.data = $scope.data || {};
  $scope.data.user = user;
  $scope.data.selectedTenant = TenantTree.selected;

  $scope.cancel = function () {
    $state.go('^.facets.grid');
  };

  $scope.saveUser = function() {
    $scope.data.user.tenant_id = $scope.data.selectedTenant.id;
    $scope.data.user.$save().then(
      function() {
        $state.go('^.facets.grid');
        flash.success = 'Saved user information';
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
