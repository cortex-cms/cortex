angular.module('cortex.controllers.localizations.edit', [
  'ui.router.state',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.util'
])

.controller('LocalizationsEditCtrl', function ($scope, $state, $stateParams, $anchorScroll, flash, cortex, util) {
  $scope.data = $scope.data || {};

  if (util.isEmpty($stateParams.localizationId)) {
    $scope.data.localization = new cortex.localizations();
  }
  else {
    $scope.data.localization = cortex.localizations.get({id: $stateParams.localizationId});
  }

  $scope.cancel = function () {
    $state.go('cortex.localizations.manage');
  };

  $scope.saveLocalization = function () {
    $scope.data.localization.$save().then(
      function () {
        $anchorScroll();
        flash.info = 'Saved localization information';
      },
      function () {
        $anchorScroll();
        flash.error = 'Error while saving localization information';
      }
    );
  }
});
