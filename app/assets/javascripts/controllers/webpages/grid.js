angular.module('cortex.controllers.webpages.grid', [
  'ngTable',
  'ui.bootstrap',
  'ui.router.state',
  'angular-flash.service',
  'cortex.services.cortex'
])

  .controller('WebpagesGridCtrl', function ($scope, $window, $state, ngTableParams, cortex, flash) {
    $scope.data = {
      totalServerItems: 0,
      webpages: [],
      query: null
    };

    $scope.webpageDataParams = new ngTableParams({
      page: 1,
      count: 10,
      sorting: {
        created_at: 'desc'
      }
    }, {
      total: 0,
      getData: function ($defer, params) {
        cortex.webpages.searchPaged({page: params.page(), per_page: params.count(), q: $scope.data.query},
          function (webpages, headers, paging) {
            params.total(paging.total);
            $defer.resolve(webpages);
          },
          function (data) {
            $defer.reject(data);
          }
        );
      }
    });

    $scope.searchWebpages = function(event) {
      if (event.which == 13) {
        $scope.webpageDataParams.reload();
      }

      event.preventDefault();
    };

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
          $scope.webpageDataParams.reload();
        }, function (res) {
          flash.error = webpage.name + " could not be deleted: " + res.data.message;
        });
      }
    };
  });
