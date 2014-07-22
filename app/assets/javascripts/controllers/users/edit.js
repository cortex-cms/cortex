angular.module('cortex.controllers.users.edit', [
  'angular-flash.service'
])

.controller('UsersEditCtrl', function($scope, $anchorScroll, flash, user, author) {
  $scope.data        = $scope.data || {};
  $scope.data.user   = user;
  $scope.data.author = author;

  $scope.saveAuthor = function() {
    $scope.data.author.$save().then(
      function() {
        $anchorScroll();
        flash.info = 'Saved author information';
      },
      function() {
        $anchorScroll();
        flash.error = 'Error while saving author information';
      }
    );
  }
});
