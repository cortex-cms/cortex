angular.module('cortex.controllers.media.grid', [
    'ui.router.state',
    'ui.bootstrap',
    'placeholders.img',
    'angular-flash.service',
    'cortex.settings',
    'cortex.services.cortex',
    'cortex.directives.delayedInput',
    'cortex.controllers.posts.edit',
    'cortex.controllers.posts.popup',
    'cortex.filters',
    'cortex.services.cortex'
])

.controller('MediaGridCtrl', function($scope, $stateParams, $state, cortex, settings, flash, PostBodyEditorService, PostsPopupService){

    $scope.data = {};

    var updatePage = function() {
        $state.go('.', {page: $scope.page.page, perPage: $scope.page.perPage, query: $scope.page.query});
    };

    $scope.page = {
        query: $stateParams.query,
        page: parseInt($stateParams.page) || 1,
        perPage: parseInt($stateParams.perPage) || settings.paging.defaultPerPage,
        next: function() {
            $scope.page.page++;
            updatePage();
        },
        previous: function() {
            $scope.page.page--;
            updatePage();
        },
        flip: function(page) {
            $scope.page.page = page;
            updatePage();
        }
    };

    $scope.$watch('page.query', function() {
        updatePage();
    });

    $scope.data.media = cortex.media.searchPaged({q: $scope.page.query,
            per_page: $scope.page.perPage,
            page: $scope.page.page},
        function(media, headers, paging) {
            $scope.data.paging = paging;
        });

    $scope.deleteMedia = function(media) {
        if (confirm('Are you sure you want to delete "' +  media.name + '?"')) {
            cortex.media.delete({id: media.id}, function() {
                $scope.data.media = _.reject($scope.data.media, function(m) { return m.id == media.id; });
                flash.info = media.name + " deleted.";
            });
        }
    };

    $scope.insertMedia = function(media) {
        PostBodyEditorService.addMedia(media);
        PostsPopupService.popupOpen = false;
    };
});
