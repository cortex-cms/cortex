angular.module('cortex.services.postsPopup', [
])

  .factory('PostsPopupService', function() {
  return {
    popupOpen: true,
    title: ''
  };
});
