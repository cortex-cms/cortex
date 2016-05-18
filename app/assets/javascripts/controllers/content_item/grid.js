angular.module('cortex.controllers.content_items.grid', [
  'ngTable',
  'ui.bootstrap',
  'cortex.services.cortex',
  'cortex.filters'
])

  .controller('ContentItemsGridCtrl', function($scope, $state, cortex) {
    $scope.data = {
      contentItems: cortex.content_items.index()
    };
  });
