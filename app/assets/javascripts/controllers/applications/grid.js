angular.module('cortex.controllers.applications.grid', [
  'ui.router.state',
  'ngTable',
  'ui.bootstrap',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.filters'
])

  .controller('ApplicationsGridCtrl', function($scope, $window, $state, ngTableParams, cortex, flash) {
    $scope.data = {
      totalServerItems: 0,
      applications: [],
      query: null
    };

    $scope.applicationsTableParams = new ngTableParams({
      page: 1,
      count: 10,
      sorting: {
        created_at: 'desc'
      }
    }, {
      total: 0,
      getData: function ($defer, params) {
        cortex.applications.searchPaged({page: params.page(), per_page: params.count()},
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

    $scope.editApplication = function(application) {
      $state.go('^.localization.edit', {id: application.id});
    };

    $scope.deleteApplication = function (application) {
      if ($window.confirm('Are you sure you want to delete "' + application.name + '?"')) {
        cortex.applications.delete({id: application.id}, function () {
          flash.warn = application.name + ' deleted.';
          $scope.applicationsTableParams.reload();
        }, function () {
          flash.error = application.name + ' could not be deleted due to an error.';
        });
      }
    };
  });
