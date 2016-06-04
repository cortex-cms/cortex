angular.module('cortex.vendor.riot', [])

.config(function($provide) {
  $provide.constant('riot', window.riot);
});
