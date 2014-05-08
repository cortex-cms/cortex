angular.module('cortex.directives.tenantSettings', [])

.directive('tenantSettings', function() {
    return {
        restrict: 'EA',
        templateUrl: 'directives/tenant-settings-tpl.html'
    };
});