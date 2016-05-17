angular.module('cortex.controllers.custom_content.grid', [
  'ngTable',
  'ui.bootstrap',
  'cortex.services.cortex',
  'cortex.filters'
])

  .controller('CustomContentGridCtrl', function($scope, $state, cortex) {
    $scope.data = {
      content_types: cortex.content_types.index()
    };



  });
