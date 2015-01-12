angular.module('cortex.controllers.users.edit', [
  'ui.router.state',
  'angular-flash.service'
])

.controller('UsersEditCtrl', function($scope, $timeout, $state, $anchorScroll, flash, user, author) {
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
  };
  $scope.changePassword = function() {
    $scope.data.user.$save().then(
        function() {
          flash.success = "Successfully updated password, redirecting to login page in 5 seconds...";
          $timeout(function () { $state.go('login') }, 5000);
        },
        function(res) {
          $anchorScroll();
          if (res.status === 403) {
            flash.error = "Current password is invalid";
          } else if (res.data.errors[0] === "password_confirmation doesn't match Password") {
            flash.error = "Passwords don't match.";
          } else {
            flash.error = "Could not change password, please try again'";
          }
        }
    );
  };
});
