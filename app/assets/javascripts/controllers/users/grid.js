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
          cortex.tenants.usersPaged({page: params.page(), per_page: params.count(), id: $scope.data.tenantTree.selected.id},
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
          flash.error = user.email + " could not be deleted: " + res.data.message;
        });
      }
    };

    $scope.deleteMedia = function (media) {
      if ($window.confirm('Are you sure you want to delete "' + media.name + '?"')) {
        cortex.media.delete({id: media.id}, function () {
          $scope.data.media = _.reject($scope.data.media, function (m) {
            return m.id == media.id;
          });
          flash.warn = media.name + " deleted.";
        }, function (res) {
          flash.error = media.name + " could not be deleted: " + res.data.message;
        });
      }
    };
  });
