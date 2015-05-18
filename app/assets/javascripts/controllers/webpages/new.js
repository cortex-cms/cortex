angular.module('cortex.controllers.webpages.new', [
  'ui.router.state',
  'angular-flash.service',
  'cortex.services.cortex'
])

.controller('WebpagesNewCtrl', function ($scope, $state, $stateParams, flash, cortex) {
  $scope.data = $scope.data || {};
  $scope.data.webpage = new cortex.webpages();

  $scope.cancel = function () {
    $state.go('^.manage');
  };

  $scope.saveWebpage = function () {
    $scope.data.webpage.$save().then(
      function () {
        flash.success = 'Saved webpage information';
        $state.go('^.manage');
      },
      function () {
        flash.error = 'Error while saving webpage information';
      }
    );
  };
});
