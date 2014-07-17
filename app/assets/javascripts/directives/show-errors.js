angular.module('cortex.directives.showErrors', [])

.factory('errorCounter', function() {
  return {}
})

.directive('showErrors', function (errorCounter, $rootScope) {
  return {
    restrict: 'A',
    require: '^form',
    link: function (scope, el, attrs, formCtrl) {
      var inputEl = el[0].querySelector("[name]");
      var inputNgEl = angular.element(inputEl);
      var inputName = inputNgEl.attr('name');

      var toggleErrors = function() {
        var invalid = formCtrl[inputName].$invalid;
        el.toggleClass('has-error', invalid);
        var parentSelector = attrs['parentSelector'];
        if (parentSelector) {
          var errors = errorCounter[parentSelector] || {};
          if (invalid) {
            errors[inputName] = true;
          }
          else if (!invalid) {
            delete errors[inputName];
          }
          errorCounter[parentSelector] = errors;
        }
        $rootScope.$broadcast('errorCountChange');
      };

      inputNgEl.on('blur select change', toggleErrors);
      scope.$on('validate', toggleErrors);
    }
  }
})
.directive('tabErrors', function(errorCounter) {
  return {
    restrict: 'A',
    link: function(scope, el, attrs) {
     scope.$on('errorCountChange', function() {
       var name = attrs.selectorName;
       var obj = errorCounter[name];
       if (typeof obj === 'object') {
         var count = Object.keys(obj).length;
         el.toggleClass('has-error', count > 0);
       }
     });
    }
  }
});