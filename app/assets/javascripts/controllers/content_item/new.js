angular.module(
  'cortex.controllers.content_items.new', 
  [
    'cortex.services.cortex',
    'cortex.filters'
  ]
)

  .controller('ContentItemsNewCtrl', function($scope, $state) {
    $scope.someText = "Some text here";

    riot.mount('contenttype', { 
      library: "RiotJS",
      someText: "With some text added in the angular controller"
    });
  });