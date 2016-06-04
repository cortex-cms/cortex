angular.module('cortex.services.imageFit', [
])

.factory('ImageFitService', function($window, flash) {
  return {
    initRedactorImageFitPlugin: function() {
      if (!$window.RedactorPlugins) {
        $window.RedactorPlugins = {};
      }

      $window.RedactorPlugins.imageFit = function() {
        return {
          init: function()
          {
            var imageFitButton = this.button.add('imageFit', 'Fit to Page');
            this.button.setAwesome('imageFit', 'fa-arrows-alt');
            this.button.addCallback(imageFitButton, this.imageFit.fitImageToPage);
          },
          fitImageToPage: function()
          {
            var imgElement = angular.element(this.selection.getCurrent()).find('img');

            if (imgElement.length) {
              imgElement.css( "width", "100%" );
            }
            else {
              flash.error = 'Image not found at selection.';
            }
          }
        };
      };
    }
  };
});
