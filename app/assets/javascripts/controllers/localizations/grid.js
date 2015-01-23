angular.module('cortex.controllers.localizations.grid', [
  'ui.router.state',
  'ngTable',
  'ui.bootstrap',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.filters'
])

  .controller('LocalizationsGridCtrl', function ($scope, $window, $state, ngTableParams, flash, cortex) {
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

    $scope.editLocalization = function(localization) {
      $state.go('^.localization.edit', {localizationId: localization.id});
    };

    $scope.deleteLocalization = function (localization) {
      if ($window.confirm('Are you sure you want to delete "' + localization.name + '?"')) {
        cortex.localizations.delete({id: localization.id}, function () {
          flash.warn = localization.name + ' deleted.';
          $scope.localizationDataParams.reload();
        }, function () {
          flash.error = localization.name + ' could not be deleted due to an error.';
        });
      }
    };

    $scope.duplicateLocalization = function (localization) {
      if ($window.confirm('Are you sure you want to duplicate "' + localization.name + '?"')) {
        var duplicate = new cortex.localizations(localization);
        delete duplicate.id;
        duplicate.name += ' - Copy';
        duplicate.$save().then(
          function () {
            flash.success = localization.name + ' duplicated.';
            $scope.localizationDataParams.reload();
          },
          function () {
            flash.error = localization.name + ' could not be duplicated due to an error.';
        });
      }
    };
  });
