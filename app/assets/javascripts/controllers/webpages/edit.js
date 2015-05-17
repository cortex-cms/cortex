angular.module('cortex.controllers.webpages.edit', [
  'ui.router.state',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.filters'
])

.controller('WebpagesEditCtrl', function ($scope, $state, $stateParams, $anchorScroll, flash, cortex) {
  $scope.data = $scope.data || {};
  $scope.data.webpage = cortex.webpages.get({id: $stateParams.webpageId});

  $scope.cancel = function () {
    $state.go('^.manage');
  };

  $scope.saveWebpage = function () {
    $scope.data.webpage.$save().then(
      function () {
        $anchorScroll();
        flash.success = 'Saved webpage information';
        $state.go('^.manage');
      },
      function () {
        $anchorScroll();
        flash.error = 'Error while saving webpage information';
      }
    );
  };
});
