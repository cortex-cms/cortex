angular.module('cortex.vendor.moment', [])

.config(function($provide) {
  $provide.constant('moment', window.moment);
});
