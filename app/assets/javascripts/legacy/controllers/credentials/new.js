angular.module('cortex.controllers.credentials.new', [
  'ui.router.state',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.util'
])

  .controller('CredentialsNewCtrl', function ($scope, $state, $stateParams, flash, cortex, util) {
    $scope.data = $scope.data || {};

    $scope.data.credentials = new cortex.credentials();

    $scope.saveCredentials = function() {
      $scope.data.credentials.$save({application_id: $stateParams.applicationId}, function() {
        flash.success = "Successfully saved " + $scope.data.credentials.name;
        $state.go('^');
      }, function(res) {
        if (res.status === 402) {
          flash.error = "Could not save " + $scope.data.credentials.name + " - " + res.data.errors[0];
        } else {
          flash.error = "Could not save " + $scope.data.credentials.name;
        }
      });
    };
    $scope.cancel = function() {
      $state.go('^');
    }
  });
