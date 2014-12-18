angular.module('cortex.controllers.locales.grid', [
  'ui.router.state',
  'ngTable',
  'ui.bootstrap',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.filters'
])

  .controller('LocalesGridCtrl', function ($scope, $window, $state, $stateParams, ngTableParams, cortex, flash) {
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
        cortex.locales.searchPaged({localization_id: $stateParams.localizationId,
            page: params.page(), per_page: params.count()},
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

    $scope.editLocale = function(locale) {
      $state.go('cortex.localizations.localization.edit_locale', {localeName: locale.name});
    };

    $scope.deleteLocale = function (locale) {
      if ($window.confirm('Are you sure you want to delete "' + locale.name + '?"')) {
        cortex.locales.delete({localization_id: $stateParams.localizationId, locale_name: locale.name}, function () {
          flash.warn = locale.name + ' deleted.';
          $scope.localeDataParams.reload();
        }, function () {
          flash.error = locale.name + ' could not be deleted due to an error.';
        });
      }
    };

    $scope.duplicateLocale = function (locale) {
      if ($window.confirm('Are you sure you want to duplicate "' + locale.name + '?"')) {
        var duplicate = new cortex.locales(locale);
        delete duplicate.id;
        duplicate.name += ' - Copy';
        duplicate.$save({localization_id: $stateParams.localizationId}).then(
          function () {
            flash.success = locale.name + ' duplicated.';
            $scope.localeDataParams.reload();
          },
          function () {
            flash.error = locale.name + ' could not be duplicated due to an error.';
          });
      }
    };
  });
