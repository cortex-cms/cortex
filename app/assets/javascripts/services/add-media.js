angular.module('cortex.services.addMedia', [
])

.factory('AddMediaService', function($state, $window,
                                     mediaSelectType, PostBodyEditorService, PostsPopupService) {
  return {
    setMedia: function(type, title) {
      PostBodyEditorService.mediaSelectType = type;
      PostsPopupService.title = title;
      $state.go('.media.manage.components');
    },
    initRedactorWithMedia: function() {
      var that = this;

      if (!$window.RedactorPlugins) {
        $window.RedactorPlugins = {};
      }

      $window.RedactorPlugins.media = {
        init: function()
        {
          this.buttonAdd('media', 'Media', this.addMediaPopup);
          this.buttonAwesome('media', 'fa-picture-o');

          this.buttonRemove('image');
          this.buttonRemove('video');

          PostBodyEditorService.redactor = this;
        },
        addMediaPopup: function()
        {
          that.setMedia(mediaSelectType.ADD_MEDIA, 'Insert Media from Media Library');
        }
      };
    }
  };
});
