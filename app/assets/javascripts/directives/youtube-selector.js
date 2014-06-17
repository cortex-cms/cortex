angular.module('cortex.directives.youtubeSelector', [
])

.directive('youtubeSelector', function() {
  return {
    restrict: 'E',
    require: '^ngModel',
    templateUrl: 'directives/youtube-selector-tpl.html',
    scope: {
      'ngModel': '='
    }
  };
});
