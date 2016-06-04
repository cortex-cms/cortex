angular.module('cortex.controllers.credentials.grid', [
  'ui.router.state',
  'ngTable',
  'ui.bootstrap',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.filters'
])

  .controller('CredentialsGridCtrl', function($scope, $window, $state, $stateParams, ngTableParams, cortex, flash) {
    $scope.data = {
      totalServerItems: 0,
      credentials: [],
      query: null
    };

    $scope.credentialsTableParams = new ngTableParams({
      page: 1,
      count: 10,
      sorting: {
        created_at: 'desc'
      }
    }, {
      total: 0,
      getData: function ($defer, params) {
        cortex.credentials.searchPaged({application_id: $stateParams.applicationId, page: params.page(), per_page: params.count()},
          function (applications, headers, paging) {
            params.total(paging.total);
            $defer.resolve(applications);
          },
          function (data) {
            $defer.reject(data);
          }
        );
      }
    });

    $scope.deleteCredential = function (credential) {
      if ($window.confirm('Are you sure you want to delete "' + credential.name + '?"')) {
        cortex.credentials.delete({application_id: $stateParams.applicationId, credential_id: credential.id}, function () {
          flash.warn = credential.name + ' deleted.';
          $scope.credentialsTableParams.reload();
        }, function () {
          flash.error = credential.name + ' could not be deleted due to an error.';
        });
      }
    };
  });
