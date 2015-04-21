angular.module('cortex.controllers.users.edit', [
  'ui.router.state',
  'angular-flash.service',
  'cortex.controllers.users.facets'
])

.controller('UsersEditCtrl', function($scope, $timeout, $state, $anchorScroll, flash, user) {
  $scope.data = $scope.data || {};
  $scope.data.user = user;

  $scope.cancel = function () {
    $state.go('^.facets.grid');
  };

  $scope.saveUser = function() {
    $scope.data.user.$save().then(
      function() {
        $state.go('^.facets.grid');
        flash.success = 'Saved user information';
      },
      function(res) {
        $anchorScroll();
        flash.error = 'Error while saving user information';
      }
    );
  };
});
