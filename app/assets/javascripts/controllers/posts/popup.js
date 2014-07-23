angular.module('cortex.controllers.posts.popup', [
  'ui.router.state',
  'cortex.filters',
  'cortex.services.postsPopup'
])

.controller('PostsPopupCtrl', function ($scope, $timeout, $state, $filter, PostsPopupService) {
  $scope.postsPopupService = PostsPopupService;
  $scope.postsPopupService.popupOpen = true;

  $scope.$watch('postsPopupService.popupOpen', function (popupOpen) {
    if (!popupOpen) {
      // We are arbitrary levels deep, so we can't transition relative to our current state.
      if ($state.includes('cortex.posts.new')) {
        // We need to wait long enough for bootstrap-modal to fade away, otherwise we're stuck with a blocked-out page
        $timeout(function () {
          $state.go($filter('postNewState')($scope.data.post));
        }, 500);
      }
      else {
        $timeout(function () {
          $state.go($filter('postEditState')($scope.data.post, false), {postId: $scope.data.post.id});
        }, 500);
      }
    }
  });
});
