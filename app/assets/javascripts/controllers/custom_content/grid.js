angular.module('cortex.controllers.custom_content.grid', [
  'ngTable',
  'ui.bootstrap',
  'cortex.services.cortex',
  'cortex.filters'
])

  .controller('CustomContentGridCtrl', function($scope, $state) {
    console.log("In the controller");
  });