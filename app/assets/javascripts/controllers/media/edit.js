angular.module('cortex.controllers.media.edit', [
  'ui.router.state',
  'ui.bootstrap.datepicker',
  'angular-flash.service',
  'cortex.filters',
  'unsavedChanges',
  'cortex.services.cortex',
  'cortex.filters'
])

.controller('MediaEditCtrl', function ($scope, $filter, $stateParams, $state, $timeout, flash, cortex, unsavedChanges) {
  $scope.datepicker = {
    format: 'yyyy/MM/dd',
    expireAtOpen: false,
    open: function (datepicker) {
      $timeout(function () {
        $scope.datepicker[datepicker] = true;
      });
    }
  };

  $scope.data = {};

  $scope.data.media = cortex.media.get({id: $stateParams.mediaId}, function (media) {
    unsavedChanges.fnListen($scope, $scope.data.media);

    $scope.data.tags = $filter('tagList')(media.tags);
  });

  $scope.update = function () {
    $scope.data.media.tag_list = $scope.data.tags;
    delete $scope.data.media.tags;

    $scope.data.media.$save(function (media) {
      unsavedChanges.fnListen($scope, $scope.data.media);

      flash.success = 'Saved media "' + media.name + '"';
      $state.go('^.manage.components');
    });
  };

  $scope.cancel = function () {
    $state.go('^.manage.components');
  };
});
