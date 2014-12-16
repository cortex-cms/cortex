angular.module('cortex.controllers.locales.grid', [
  'ui.router.state',
  'ngTable',
  'ui.bootstrap',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.filters'
])

  .controller('LocalesGridCtrl', function ($scope, $window, $stateParams, ngTableParams, cortex, flash) {
    $scope.data = {
      totalServerItems: 0,
      locales: [],
      query: null
    };

    $scope.localeDataParams = new ngTableParams({
      page: 1,
      count: 10,
      sorting: {
        created_at: 'desc'
      }
    }, {
      total: 0,
      getData: function ($defer, params) {
        cortex.locales.searchPaged({localization_id: $stateParams.localizationId, page: params.page(), per_page: params.count()},
          function (locales, headers, paging) {
            params.total(paging.total);
            $defer.resolve(locales);
          },
          function (data) {
            $defer.reject(data);
          }
        );
      }
    });

    $scope.deleteLocale = function (locale) {
      if ($window.confirm('Are you sure you want to delete "' + locale.name + '?"')) {
        cortex.locales.delete({id: locale.id}, function () {
          flash.warn = locale.name + " deleted.";
          $scope.localeDataParams.reload();
        }, function (res) {
          flash.error = locale.name + " could not be deleted: " + res.data.message;
        });
      }
    };
  });
