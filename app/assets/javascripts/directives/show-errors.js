angular.module('cortex.directives.showErrors', [])

.directive('showErrors', function () {
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
      // get the extra validation parameter from data-parentSelector
      var parentSelector = attrs['parentSelector'];

      // only apply the has-error class after the user leaves the text box
      inputNgEl.bind('blur', function () {
        var otherElement = angular.element(parentSelector);
        el.toggleClass('has-error', formCtrl[inputName].$invalid);
        otherElement.toggleClass('has-error', formCtrl[inputName].$invalid);
      })
    }
  }
});