var module = angular.module('cortex.session', []);

module.config(function($provide) {
  $provide.constant('currentUser', angular.copy(window.gon.current_user));
});
