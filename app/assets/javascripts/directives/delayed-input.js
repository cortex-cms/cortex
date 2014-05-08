angular.module('cortex.directives.delayedInput', [])

.directive('delayedInput', function($timeout) {
    return {
        restrict: 'E',
        require: 'ngModel',
        template: '<input type="text" ng-change="pendingChange()" ng-model="pendingValue" class="{{class}}" placeholder="{{placeholder}}"/>',
        scope: {
          delay:       '@',
          placeholder: '@',
          class:       '@',
          value:       '=ngModel',
          change:      '&ngChange'
        },
        link: function(scope, elem, attr, ctrl) {
            scope.pendingValue = scope.value;
            elem.removeClass(scope.class);

            scope.pendingChange = function() {
                if (scope.pending) { $timeout.cancel(scope.pending); }
                    scope.pending = $timeout(function() {
                    scope.value = scope.pendingValue;
                    ctrl.$setViewValue(scope.value);
                }, parseInt(scope.delay));
            };
        }
    };
});
