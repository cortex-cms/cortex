angular.module('cortex.controllers.content_types.grid', [
  'ngTable',
  'ui.bootstrap',
  'cortex.services.cortex',
  'cortex.filters'
])

  .controller('ContentTypesGridCtrl', function($scope, $state, cortex) {
    $scope.data = {
      content_types: cortex.content_types.index()
    };



  });
