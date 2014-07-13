angular.module('cortex.controllers.posts.edit.info', [
  'cortex.services.cortex',
  'cortex.filters'
])

.controller('PostsEditInfoCtrl', function($scope, $filter, cortex) {

    // Auto-generate slug when title changed and field isn't dirty
    $scope.$watch('data.post.title', function(title) {
      if ($scope.postForm.slug.$dirty && $scope.postForm.slug) {
        return;
      }
      $scope.data.post.slug = $filter('slugify')($scope.data.post.title);
    });

    $scope.$watch('data.post.slug', function(slug) {

      if (!slug) {
        return;
      }

      cortex.posts.get({id: slug},
        // Slug already used
        function(post) {

          // A post may have its own slug
          if (post.id === $scope.data.post.id) {
            $scope.postForm.slug.$error.unavailable = false;
            $scope.data.postWithDuplicateSlug = null;
          }
          else {
            $scope.postForm.slug.$error.unavailable = true;
            $scope.data.postWithDuplicateSlug = post;
          }
        },
        // Slug unused
        function() {
          $scope.postForm.slug.$error.unavailable = false;
          $scope.data.postWithDuplicateSlug = null;
        }
      );
    });
});
