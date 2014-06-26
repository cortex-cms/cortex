function youtubeIdFromUrl(url) {
  var match = url.match(/^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/);
  return match && match[2].length == 11 ? match[2] : null;
};

angular.module('cortex.directives.youtubeSelector', [
])

// http://stackoverflow.com/questions/20447867/create-a-youtube-angularjs-directive
.directive('youtube', function($sce) {
  return {
    restrict: 'EA',
    scope: { code: '=' },
    replace: true,
    template: '<div style="height:400px;"><iframe style="overflow:hidden;height:100%;width:100%" width="100%" height="100%" src="{{url}}" frameborder="0" allowfullscreen></iframe></div>',
    link: function (scope) {
      scope.$watch('code', function (newVal) {
        if (newVal) {
          scope.url = $sce.trustAsResourceUrl("http://www.youtube.com/embed/" + newVal);
        }
      });
    }
  };
})

.controller('YoutubeSelectorCtrl', function($scope) {
  $scope.$watch('youtubeLink', function() {

    if (!$scope.youtubeLink) {
      $scope.ngModel = null;
      return;
    }

    $scope.ngModel = youtubeIdFromUrl($scope.youtubeLink);
  });
})

.directive('youtubeSelector', function() {
  return {
    restrict: 'E',
    require: '^ngModel',
    templateUrl: 'directives/youtube-selector-tpl.html',
    controller: 'YoutubeSelectorCtrl',
    scope: {
      'ngModel': '='
    }
  };
});
