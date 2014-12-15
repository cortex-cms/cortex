angular.module('cortex.controllers.locales.edit', [
  'ui.router.state',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.util'
])

.controller('LocalesEditCtrl', function ($scope, $state, $stateParams, $anchorScroll, flash, cortex, util) {
  $scope.data = $scope.data || {};

  if (util.isEmpty($stateParams.localeId)) {
    $scope.data.locale = new cortex.locales();
  }
  else {
    $scope.data.locale = cortex.locales.get({localization_id: $stateParams.localizationId, id: $stateParams.localeId});
  }

  $scope.cancel = function () {
    $state.go('^.edit');
  };

  $scope.saveLocale = function () {
    $scope.data.locale.$save({localization_id: $stateParams.localizationId}).then(
      function () {
        $anchorScroll();
        flash.info = 'Saved locale information';
      },
      function () {
        $anchorScroll();
        flash.error = 'Error while saving locale information';
      }
    );
  }
});
