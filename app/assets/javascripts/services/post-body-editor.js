angular.module('cortex.services.postBodyEditor', [
  'cortex.filters'
])

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
