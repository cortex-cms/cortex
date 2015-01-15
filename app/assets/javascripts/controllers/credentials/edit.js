angular.module('cortex.controllers.credentials.edit', [
  'ui.router.state',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.util'
])

  .controller('CredentialsEditCtrl', function ($scope, $state, $stateParams, $anchorScroll, flash, cortex, util) {
    $scope.data = $scope.data || {};

    $scope.data.credentials = cortex.credentials.get({application_id: $stateParams.applicationId,
      credentials_id: $stateParams.credentialsId});

    $scope.saveCredentials = function() {
      $scope.data.credentials.$save({application_id: $stateParams.applicationId,
        credentials_id: $stateParams.credentialsId}, function() {
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
