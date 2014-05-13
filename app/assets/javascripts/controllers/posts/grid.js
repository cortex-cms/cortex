angular.module('cortex.controllers.posts.grid', [
    'ngTable',
    'ui.bootstrap',
    'cortex.services.cortex',
    'cortex.filters'
])

.controller('PostsGridCtrl', function($scope, ngTableParams, cortex){
    $scope.data = {
        totalServerItems: 0,
        posts: []
    };

    $scope.postDataParams = new ngTableParams({
      page: 1,
      count: 10,
      sorting: {
        created_at: 'desc'
      }
    }, {
      total: 0,
      getData: function($defer, params) {
        cortex.posts.searchPaged({page: params.page(), per_page: params.count()},
          function(posts, headers, paging) {
            params.total(paging.total);
            $defer.resolve(posts);
          },
          function(data) {
            $defer.reject(data);
          }
        );
      }
    });
});
