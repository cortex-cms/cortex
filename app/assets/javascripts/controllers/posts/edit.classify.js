angular.module('cortex.controllers.posts.edit.classify', [
  'cortex.directives.modalShow',
  'cortex.services.cortex',
  'ngTagsInput'
])

.controller('PostsEditClassifyCtrl', function($scope, _, cortex) {
    $scope.loadTags = function (search) {
      return cortex.posts.tags({s: search}).$promise;
    };

    $scope.data.popularTags = cortex.posts.tags({popular: true});

    // Adds a tag to tag_list if it doesn't already exist in array
    $scope.addTag = function(tag) {
      if (_.some($scope.data.post.tag_list, function(t) { return t.name == tag.name; })) {
        return;
      }
      $scope.data.post.tag_list.push({name: tag.name, id: tag.id});
    };
});
