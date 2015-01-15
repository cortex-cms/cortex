angular.module('cortex.controllers.users.grid', [
  'ngTable',
  'ui.bootstrap',
  'cortex.services.cortex',
  'cortex.filters',
  'cortex.controllers.users.facets'
])

  .controller('UsersGridCtrl', function ($scope, ngTableParams, cortex, TenantTree) {
    $scope.data = {
      totalServerItems: 0,
      users: [],
      query: null,
      tenantTree: TenantTree
    };

    $scope.userDataParams = new ngTableParams({
      page: 1,
      count: 10,
      sorting: {
        created_at: 'desc'
      }
    }, {
      total: 0,
      getData: function ($defer, params) {
        cortex.users.searchPaged({page: params.page(), per_page: params.count(), q: $scope.data.query},
          function (users, headers, paging) {
            params.total(paging.total);
            $defer.resolve(users);
          },
          function (data) {
            $defer.reject(data);
          }
        );
      }
    });

    $scope.$watch('data.query', function () {
      $scope.userDataParams.reload();
    });

    $scope.$watch('data.tenantTree.selected', function () {
      $scope.userDataParams.reload();
    });
  });
