angular.module('cortex.controllers.media.grid', [
    'ui.router.state',
    'ui.bootstrap',
    'placeholders.img',
    'angular-flash.service',
    'cortex.settings',
    'cortex.services.cortex',
    'cortex.services.postBodyEditor',
    'cortex.services.postsPopup',
    'cortex.directives.delayedInput',
    'cortex.filters'
])

.controller('MediaGridCtrl', function($scope, $state, $stateParams, $window, cortex, settings,
                                      mediaSelectType, flash, PostBodyEditorService,
                                      PostsPopupService) {

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

    $scope.$watch('page.perPage', function() {
      updatePage();
    });

    $scope.data.media = cortex.media.searchPaged({q: $scope.page.query,
            per_page: $scope.page.perPage,
            page: $scope.page.page},
        function(media, headers, paging) {
            $scope.data.paging = paging;
        });

    $scope.deleteMedia = function(media) {
        if ($window.confirm('Are you sure you want to delete "' +  media.name + '?"')) {
            cortex.media.delete({id: media.id}, function() {
                $scope.data.media = _.reject($scope.data.media, function(m) { return m.id == media.id; });
                flash.info = media.name + " deleted.";
            }, function(res) {
              flash.error = media.name + " could not be deleted: " + res.data.message;
            });
        }
    };

    $scope.selectMedia = function(media) {
        if (PostBodyEditorService.mediaSelectType === mediaSelectType.ADD_MEDIA) {
          PostBodyEditorService.addMediaToPost(media);
        }
        else if(PostBodyEditorService.mediaSelectType === mediaSelectType.SET_TILE) {
          PostBodyEditorService.media.tile = media;
        }
        else if(PostBodyEditorService.mediaSelectType === mediaSelectType.SET_FEATURED) {
          PostBodyEditorService.media.featured = media;
        }
        else {
          throw 'No mediaSelectType set!';
        }

        PostsPopupService.popupOpen = false;
    };
});
