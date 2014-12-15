angular.module('cortex.controllers.localizations.grid', [
  'ngTable',
  'ui.bootstrap',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.filters'
])

  .controller('LocalizationsGridCtrl', function ($scope, $window, ngTableParams, cortex, flash) {
    $scope.data = {
      totalServerItems: 0,
      localizations: [],
      query: null
    };

    $scope.localizationDataParams = new ngTableParams({
      page: 1,
      count: 10,
      sorting: {
        created_at: 'desc'
      }
    }, {
      total: 0,
      getData: function ($defer, params) {
        cortex.localizations.searchPaged({page: params.page(), per_page: params.count()},
          function (localizations, headers, paging) {
            params.total(paging.total);
            $defer.resolve(localizations);
          },
          function (data) {
            $defer.reject(data);
          }
        );
      }
    });

    $scope.deleteLocalization = function (localization) {
      if ($window.confirm('Are you sure you want to delete "' + localization.name + '?"')) {
        cortex.localizations.delete({id: localization.id}, function () {
          $scope.data.localizations = _.reject($scope.data.localizations, function (l) {
            return l.id == localization.id;
          });
          flash.info = localization.name + " deleted.";
        }, function (res) {
          flash.error = localization.name + " could not be deleted: " + res.data.message;
        });
      }
    };
  });
