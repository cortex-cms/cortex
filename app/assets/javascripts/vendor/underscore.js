var module = angular.module('cortex.vendor.underscore', []);

module.config(function($provide) {
  $provide.constant('_', window._);
});
