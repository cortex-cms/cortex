angular.module('cortex.services.imageFit', [
])

.factory('ImageFitService', function($window, flash) {
  return {
    initRedactorImageFitPlugin: function() {
      if (!$window.RedactorPlugins) {
        $window.RedactorPlugins = {};
      }

      $window.RedactorPlugins.imageFit = {
        init: function()
        {
          this.buttonAdd('imageFit', 'Fit to Page', this.fitImageToPage);
          this.buttonAwesome('imageFit', 'fa-arrows-alt');
        },
        fitImageToPage: function()
        {
          var imgElement = angular.element(this.getCurrent()).find('img');

          if (imgElement.length) {
            imgElement.css( "width", "100%" );
          }
          else {
            flash.error = 'Image not found at selection.';
          }
        }
      };
    }
  };
});
