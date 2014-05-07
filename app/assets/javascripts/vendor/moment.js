var module = angular.module('cortex.vendor.moment', []);

module.config(function($provide) {
  $provide.constant('moment', window.moment);
});
