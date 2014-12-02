angular.module('cortex.controllers.locales.grid', [
  'ui.router.state',
  'ui.bootstrap',
  'angular-flash.service',
  'cortex.settings',
  'cortex.services.cortex',
  'cortex.directives.delayedInput',
  'cortex.filters'
])

  .controller('LocalesGridCtrl', function ($scope, $state, $stateParams, $window, cortex, settings, flash) {

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

    $scope.data.locales = cortex.locales.searchPaged({
        q: $scope.page.query,
        per_page: $scope.page.perPage,
        page: $scope.page.page
      },
      function (locales, headers, paging) {
        $scope.data.paging = paging;
      });

    $scope.deleteLocale = function (locale) {
      if ($window.confirm('Are you sure you want to delete "' + locale.name + '?"')) {
        cortex.locales.delete({id: locale.id}, function () {
          $scope.data.locales = _.reject($scope.data.locales, function (l) {
            return l.id == locale.id;
          });
          flash.info = locale.name + " deleted.";
        }, function (res) {
          flash.error = locale.name + " could not be deleted: " + res.data.message;
        });
      }
    };
  });
