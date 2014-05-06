var module = angular.module('cortex.controllers.posts.popup', [
    'ui.router.state'
]);

module.controller('PostsPopupCtrl', function($scope, $timeout, $state, PostsPopupService){
    $scope.postsPopupService = PostsPopupService;
    $scope.postsPopupService.popupOpen = true;

    $scope.$watch('postsPopupService.popupOpen', function(popupOpen) {
        if (!popupOpen) {
            // We are arbitrary levels deep, so we can't transition relative to our current state.
            if ($state.includes('admin.posts.new')) {
                // We need to wait long enough for bootstrap-modal to fade away, otherwise we're stuck with a blocked-out page
                $timeout(function () { $state.go('admin.posts.new'); }, 500);
            }
            else {
                $timeout(function () { $state.go('admin.posts.edit'); }, 500);
            }
        }
    });
});

module.factory('PostsPopupService', function() {
    return {
        popupOpen: true
    };
});
