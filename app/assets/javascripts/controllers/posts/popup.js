angular.module('cortex.controllers.posts.popup', [
  'ui.router.state',
  'cortex.services.postsPopup'
])

.controller('PostsPopupCtrl', function ($scope, $timeout, $state, PostsPopupService) {
  $scope.postsPopupService = PostsPopupService;
  $scope.postsPopupService.popupOpen = true;

  $scope.$watch('postsPopupService.popupOpen', function (popupOpen) {
    if (!popupOpen) {
      // We are arbitrary levels deep, so we can't transition relative to our current state.
      if ($state.includes('cortex.posts.new')) {
        // We need to wait long enough for bootstrap-modal to fade away, otherwise we're stuck with a blocked-out page
        $timeout(function () {
          $state.go('cortex.posts.new.sections.article');
        }, 500);
      }
      else {
        $timeout(function () {
          $state.go('cortex.posts.edit.sections.article');
        }, 500);
      }
    }
  });
});
