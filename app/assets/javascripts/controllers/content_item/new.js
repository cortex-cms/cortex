angular.module(
  'cortex.controllers.content_items.new',
  [
    'cortex.services.cortex',
    'cortex.filters'
  ]
)

  .controller('ContentItemsNewCtrl', function($scope, $state, cortex) {
    $scope.someText = "Some text here";

    $scope.data.contentType = cortex.content_types.get({id: 1});
    $scope.data.contentItem = new cortex.content_items();

    $scope.create = function(){
      debugger;
      console.log("submitted item");
    };


    riot.mount('contenttype', {
      library: "RiotJS",
      someText: "With some text added in the angular controller"
    });
  });
