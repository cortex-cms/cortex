angular.module('cortex.controllers.posts.edit.display', [
  'cortex.filters',
  'cortex.settings',
  'cortex.services.mediaConstraints'
])

.controller('PostsEditDisplayCtrl', function($scope, $state, PostBodyEditorService, PostsPopupService, mediaSelectType, featuredMediaConstraintsService, tileMediaConstraintsService) {

    $scope.postBodyEditorService = PostBodyEditorService;
    $scope.postBodyEditorService.media.featured = $scope.data.post.featured_media;
    $scope.postBodyEditorService.media.tile = $scope.data.post.tile_media;


    var setMedia = function(type, title) {
      $scope.postBodyEditorService.mediaSelectType = type;
      PostsPopupService.title = title;
      $state.go('.media.manage.components');
    };

    $scope.setFeaturedMedia = function () {
      setMedia(mediaSelectType.SET_FEATURED, 'Set Featured Media from Media Library');
    };

    $scope.removeFeaturedMedia = function () {
      $scope.data.post.featured_media = {};
      $scope.data.post.featured_media_id = null;
      $scope.data.featured_media_too_small = false;
    };

    $scope.setTileMedia = function () {
      setMedia(mediaSelectType.SET_TILE, 'Set Tile Media from Media Library');
    };

    $scope.removeTileMedia = function () {
      $scope.data.post.tile_media = {};
      $scope.data.post.tile_media_id = null;
      $scope.data.tile_media_too_small = false;
    };

    $scope.$watch('postBodyEditorService.media.featured', function (media) {
      if (media) {
        $scope.data.post.featured_media = media;
        $scope.data.post.featured_media_id = media.id;
        $scope.data.post.featured_media_warnings = [];
        if (!featuredMediaConstraintsService.width(media)) {
          if (featuredMediaConstraintsService.totalSize(media)) {
            $scope.data.post.featured_media_warnings.push("Warning! Your featured media might appear stretched, as it is smaller than the featured image slot. Try an image at least 1100x600 ")
          }
          else {
            $scope.data.post.featured_media_warnings.push("Warning! Your featured media might appear stretched, as it is smaller than our recommended width of 1100px.")
          }
        }
        if (!featuredMediaConstraintsService.aspectratio(media)) {
          $scope.data.post.featured_media_warnings.push("Warning! Your featured media might appear, as it does not match our recommended aspect ratio. Try 16:9");
        }
      }
    });

    $scope.$watch('postBodyEditorService.media.tile', function (media) {
      if (media) {
        $scope.data.post.tile_media = media;
        $scope.data.post.tile_media_id = media.id;
        $scope.data.post.tile_media_warnings = [];
        if (!tileMediaConstraintsService.width(media)) {
          $scope.data.post.tile_media_warnings.push("Warning! Your tile media might appear stretched, as it is smaller than our recommended width of 375.");
        }
        if (!tileMediaConstraintsService.aspectratio(media)) {
          $scope.data.post.tile_media_warnings.push("Warning! Your tile media might not display properly, as it does not match our recommended aspect ratio. Try 1:1 or 4:3.");
        }
      }
    });
})

.factory('PostBodyEditorService', function($filter) {
  return {
    redactor: {},
    mediaSelectType: '',
    media: {
      featured: {},
      tile: {}
    },
    addMediaToPost: function (media) {
      this.redactor.insertHtml($filter('mediaToHtml')(media));
    }
  };
});
