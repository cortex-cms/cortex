angular.module('cortex.controllers.users.grid', [
  'ngTable',
  'ui.router.state',
  'ui.bootstrap',
  'angular-flash.service',
  'cortex.services.cortex',
  'cortex.filters',
  'cortex.controllers.users.facets'
])

  .controller('UsersGridCtrl', function ($scope, $window, $state, ngTableParams, flash, cortex, TenantTree) {
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
        if ($scope.data.tenantTree.selected) {
          cortex.tenants.usersPaged({page: params.page(), per_page: params.count(), id: $scope.data.tenantTree.selected.id, q: $scope.data.query},
            function (users, headers, paging) {
              params.total(paging.total);
              $defer.resolve(users);
            },
            function (data) {
              $defer.reject(data);
            }
          );
        }
      }
    });

    $scope.$watch('data.query', function () {
      $scope.userDataParams.reload();
    });

    $scope.$watch('data.tenantTree.selected', function () {
      $scope.userDataParams.reload();
    });

    $scope.editUser = function(user) {
      $state.go('^.^.edit', {userId: user.id});
    };

    $scope.deleteUser = function (user) {
      if ($window.confirm('Are you sure you want to delete "' + user.email + '?"')) {
        cortex.users.delete({id: user.id}, function () {
          flash.warn = user.email + ' deleted.';
          $scope.userDataParams.reload();
        }, function (res) {
          if (res.status === 409) {
            flash.error = user.email + " is currently assigned to Content or Media and cannot be deleted";
          } else {
            flash.error = user.email + " could not be deleted: " + res.data.message;
          }
        });
      }
    };
  });
