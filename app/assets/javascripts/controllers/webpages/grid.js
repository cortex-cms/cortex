angular.module('cortex.controllers.webpages.grid', [
  'ui.router.state',
  'placeholders.img',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.settings'
])

  .controller('WebpagesGridCtrl', function ($scope, $window, $state, $stateParams, cortex, settings, flash) {
    var updatePage = function () {
      $state.go('.', {page: $scope.page.page, perPage: $scope.page.perPage, query: $scope.page.query});
    };

    $scope.data = $scope.data || {};
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
    $scope.data.webpages = cortex.webpages.searchPaged({
        q: $scope.page.query,
        per_page: $scope.page.perPage,
        page: $scope.page.page
      },
      function (webpages, headers, paging) {
        $scope.data.paging = paging;
      });

    $scope.newWebpage = function () {
      $state.go('^.new');
    };

    $scope.editWebpage = function (webpage) {
      $state.go('^.edit', {webpageId: webpage.id});
    };

    $scope.deleteWebpage = function (webpage) {
      if ($window.confirm('Are you sure you want to delete "' + webpage.name + '" with URL "' + webpage.url + '", and all associated Snippets/Documents?"')) {
        cortex.webpages.delete({id: webpage.id}, function () {
          $scope.data.webpages = _.reject($scope.data.webpages, function (w) {
            return w.id == webpage.id;
          });
          flash.warn = webpage.name + " deleted.";
        }, function (res) {
          flash.error = webpage.name + " could not be deleted: " + res.data.message;
        });
      }
    };
  });
