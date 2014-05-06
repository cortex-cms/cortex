var module = angular.module('cortex.directives.tenantSettings', []);

module.directive('tenantSettings', function() {
    return {
        restrict: 'EA',
        templateUrl: 'directives/tenant-settings.html'
    };
});