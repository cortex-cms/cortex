angular.module('cortex.directives.showErrors', [])

.directive('showErrors', function ($filter) {
  return {
    restrict: 'A',
    require: '^form',
    link: function (scope, el, attrs, formCtrl) {
      // find the text box element, which has the 'name' attribute
      var inputEl = el[0].querySelector("[name]");
      // convert the native text box element to an angular element
      var inputNgEl = angular.element(inputEl);
      // get the name on the text box
      var inputName = inputNgEl.attr('name');

      var toggleErrors = function() {
        var invalid = formCtrl[inputName].$invalid;
        var origStateIsInvalid = el.hasClass('has-error');
        el.toggleClass('has-error', invalid);
        var parentSelector = attrs['parentSelector'];
        if (parentSelector) {
          var pe = angular.element(parentSelector);
          var errors = parseInt(pe.attr('data-validation-errors'));
          if (origStateIsInvalid && !invalid) {
            errors -= 1;
            pe.attr('data-validation-errors', errors);
          }
          else if (!origStateIsInvalid && invalid) {
            errors += 1;
            pe.attr('data-validation-errors', errors);
          }
        }
      };

      // only apply the has-error class after the user leaves the text box
      inputNgEl.bind('blur select change', toggleErrors);
      scope.$on('validate', toggleErrors);
    }
  }
});