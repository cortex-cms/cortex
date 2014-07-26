angular.module('cortex.controllers.posts.edit.seo', [
  'cortex.services.cortex',
  'cortex.filters'
])

.controller('PostsEditSeoCtrl', function($scope, $filter) {
      // SEO Title should be pulled from the post title, unless it's been edited.
      $scope.$watch('data.post.title', function(description) {
        if ($scope.postForm.seo_title.$dirty && $scope.postForm.seo_title) {
          return;
        }
        $scope.data.post.seo_title = $filter('slugify')($scope.data.post.title);
      });

      // Ditto SEO Description
      $scope.$watch('data.post.short_description', function(description) {
        if ($scope.postForm.seo_description.$dirty && $scope.postForm.seo_description) {
          return;
        }
        $scope.data.post.seo_description = $scope.data.post.short_description;
      });
});
