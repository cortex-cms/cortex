angular.module('cortex.controllers.bulk_jobs.grid', [
  'ngTable',
  'ui.bootstrap',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.filters'
])

  .controller('BulkJobsGridCtrl', function ($scope, ngTableParams, flash, cortex) {
    $scope.data = {
      totalServerItems: 0,
      bulk_jobs: [],
      query: null
    };

    $scope.bulkJobDataParams = new ngTableParams({
      page: 1,
      count: 10,
      sorting: {
        created_at: 'desc'
      }
    }, {
      total: 0,
      getData: function ($defer, params) {
        cortex.bulk_jobs.searchPaged({page: params.page(), per_page: params.count()},
          function (bulk_jobs, headers, paging) {
            params.total(paging.total);
            $defer.resolve(bulk_jobs);
          },
          function (data) {
            $defer.reject(data);
          }
        );
      }
    });
  });
