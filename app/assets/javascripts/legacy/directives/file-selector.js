angular.module('cortex.directives.fileSelector', [
  'angularFileUpload'
])

.directive('fileSelector', function() {
  return {
    restrict: 'E',
    require: '^ngModel',
    templateUrl: 'directives/file-selector-tpl.html',
    scope: {
      'ngModel':  '=',
      'multiple': '='
    },
    link: function(scope, element) {
      // The file input is required to trigger an open file dialog (OFD)
      var fileInput = element.find('input[type="file"]');
      var multiple  = scope.multiple;

      // Allow multiple file selection
      if (multiple) {
        fileInput.attr('multiple', '');
      }

      scope.selectFiles = function(files) {
        if (multiple) {
          scope.ngModel = files;
          scope.files = files;
        }
        else {
          scope.ngModel = files[0];
          scope.files = [files[0]];
        }
      };

      // Trigger OFD
      scope.browseForFiles = function() {
        fileInput.click();
      };

      scope.remove = function(file) {
        scope.files.splice(scope.files.indexOf(file), 1);
        scope.ngModel = scope.files;
      };
    }
  };
});
