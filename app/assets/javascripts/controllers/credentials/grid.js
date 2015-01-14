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

    //$scope.newApplication = function() {
    //  var application = new cortex.applications();
    //  var name = $window.prompt("Provide a name for the application");
    //  if (name !== null && name !== '') {
    //    application.name = name;
    //    application.$save(function() {
    //        flash.success = "Successfully created new application " + name;
    //        $scope.applicationsTableParams.reload();
    //      },
    //      function () {
    //        flash.error = "Could not create new application, please try again.";
    //      });
    //  }
    //};
    //
    //$scope.editApplication = function(application) {
    //  var name = $window.prompt("Provide a new name for the application");
    //  if (name !== null && name !== '') {
    //    application.name = name;
    //    application.$save(function() {
    //        flash.success = "Successfully renamed application " + name;
    //        $scope.applicationsTableParams.reload();
    //      },
    //      function () {
    //        flash.error = "Could not rename application, please try again.";
    //      });
    //  }
    //};
    //
    //$scope.deleteApplication = function (application) {
    //  if ($window.confirm('Are you sure you want to delete "' + application.name + '?"')) {
    //    cortex.applications.delete({id: application.id}, function () {
    //      flash.warn = application.name + ' deleted.';
    //      $scope.applicationsTableParams.reload();
    //    }, function () {
    //      flash.error = application.name + ' could not be deleted due to an error.';
    //    });
    //  }
    //};
  });
