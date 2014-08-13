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

  });

  $scope.update = function () {
    $scope.data.media.tag_list = $scope.data.media.tag_list.map(function(tag) { return tag.name; });

    $scope.data.media.$save(function (media) {
      unsavedChanges.fnListen($scope, $scope.data.media);

      flash.success = 'Saved media "' + media.name + '"';
      $state.go('^.manage.components');
    });
  };

  $scope.cancel = function () {
    $state.go('^.manage.components');
  };

  $scope.loadTags = function (search) {
    return cortex.media.tags({s: search}).$promise;
  };

  $scope.data.popularTags = cortex.media.tags({popular: true});

  // Adds a tag to tag_list if it doesn't already exist in array
  $scope.addTag = function(tag) {
    if (_.some($scope.data.media.tag_list, function(t) { return t.name == tag.name; })) {
      return;
    }
    $scope.data.media.tag_list.push({name: tag.name, id: tag.id});
  };
});
