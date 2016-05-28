angular.module('cortex.services.addMedia', [
  'cortex.services.postBodyEditor',
  'cortex.services.postsPopup'
])

.factory('AddMediaService', function($state, $window,
                                     mediaSelectType, PostBodyEditorService, PostsPopupService) {
  return {
    setMedia: function(type, title) {
      PostBodyEditorService.mediaSelectType = type;
      PostsPopupService.title = title;
      $state.go('.media.manage.components');
    },
    initRedactorMediaPlugin: function() {
      var that = this;

      if (!$window.RedactorPlugins) {
        $window.RedactorPlugins = {};
      }

      $window.RedactorPlugins.media = function() {
        return {
          init: function()
          {
            var mediaButton = this.button.add('media', 'Media');
            this.button.setAwesome('media', 'fa-picture-o');
            this.button.addCallback(mediaButton, this.media.addMediaPopup);

            this.button.remove('image');
            this.button.remove('video');

            PostBodyEditorService.redactor = this;
          },
          addMediaPopup: function()
          {
            that.setMedia(mediaSelectType.ADD_MEDIA, 'Insert Media from Media Library');
          }
        };
      };
    }
  };
});
