angular.module('cortex.vendor.underscore', [])

.config(function($provide) {
  $provide.constant('_', window._);
});
