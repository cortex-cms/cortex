angular.module('cortex.controllers.localizations.grid', [
  'ui.router.state',
  'ui.bootstrap',
  'angular-flash.service',
  'cortex.settings',
  'cortex.services.cortex',
  'cortex.directives.delayedInput',
  'cortex.filters'
])

  .controller('LocalizationsGridCtrl', function ($scope, $state, $stateParams, $window, cortex, settings, flash) {

    $scope.data = {};

    var updatePage = function () {
      $state.go('.', {page: $scope.page.page, perPage: $scope.page.perPage, query: $scope.page.query});
    };

    $scope.page = {
      query: $stateParams.query,
      page: parseInt($stateParams.page) || 1,
      perPage: parseInt($stateParams.perPage) || settings.paging.defaultPerPage,
      next: function () {
        $scope.page.page++;
        updatePage();
      },
      previous: function () {
        $scope.page.page--;
        updatePage();
      },
      flip: function (page) {
        $scope.page.page = page;
        updatePage();
      }
    };

    $scope.$watch('page.query', function () {
      updatePage();
    });

    $scope.$watch('page.perPage', function () {
      updatePage();
    });

    $scope.data.localizations = cortex.localizations.searchPaged({
        q: $scope.page.query,
        per_page: $scope.page.perPage,
        page: $scope.page.page
      },
      function (localizations, headers, paging) {
        $scope.data.paging = paging;
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
