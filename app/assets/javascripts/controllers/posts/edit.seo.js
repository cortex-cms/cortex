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
        $scope.data.post.seo_title = $scope.data.post.title;
      });

      // Ditto SEO Description
      $scope.$watch('data.post.short_description', function(description) {
        if ($scope.postForm.seo_description.$dirty && $scope.postForm.seo_description) {
          return;
        }
        $scope.data.post.seo_description = $scope.data.post.short_description;
      });

      $scope.addTag = function(tag) {
        if (_.some($scope.data.post.seo_keyword_list, function(t) { return t.name == tag.name; })) {
          return;
        }
        $scope.data.post.seo_keyword_list.push({name: tag.name, id: tag.id});
      };
});
