angular.module('cortex.session', [])

.config(function($provide) {
  $provide.constant('currentUser', angular.copy(window.gon.current_user));
});
