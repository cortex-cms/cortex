angular.module('cortex.controllers.locales.edit', [
  'ui.router.state',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.util'
])

.controller('LocalesEditCtrl', function ($scope, $state, $stateParams, $anchorScroll, flash, cortex, util) {
  $scope.data = $scope.data || {};
  var saveParams = {};

  if (util.isEmpty($stateParams.localeName)) {
    saveParams = {localization_id: $stateParams.localizationId};
    $scope.data.locale = new cortex.locales();
  }
  else {
    saveParams = {localization_id: $stateParams.localizationId, locale_name: $stateParams.localeName};
    $scope.data.locale = cortex.locales.get(saveParams);
  }

  $scope.cancel = function () {
    $state.go('^.edit');
  };

  $scope.saveLocale = function () {
    delete $scope.data.locale.json;
    $scope.data.locale.$save(saveParams).then(
      function () {
        $anchorScroll();
        flash.success = 'Saved locale information';
        $state.go('^.edit');
      },
      function () {
        $anchorScroll();
        flash.error = 'Error while saving locale information';
      }
    );
  };
});
