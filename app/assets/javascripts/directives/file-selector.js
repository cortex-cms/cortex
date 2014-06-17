angular.module('cortex.directives.fileSelector', [
  'angularFileUpload'
])

.directive('fileSelector', function() {
  return {
    restrict: 'E',
    require: '^ngModel',
    templateUrl: 'directives/file-selector-tpl.html',
    scope: {
      'ngModel': '='
    }
  };
});
