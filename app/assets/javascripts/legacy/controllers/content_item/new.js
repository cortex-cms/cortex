angular.module(
  'cortex.controllers.content_items.new',
  [
    'cortex.services.cortex',
    'cortex.filters',
    'angular-flash.service'
  ]
)

  .controller('ContentItemsNewCtrl', function($scope, $state, cortex, flash) {
    var contentTypeId = 1;
    $scope.someText = "Some text here";

    $scope.data.contentType = cortex.content_types.get({id: contentTypeId});
    $scope.data.contentType.$promise.then(function(thingy) {
      $scope.data.contentItem = new cortex.content_items({
        content_type_id: thingy.id,
        field_items_attributes: _.map(thingy.fields, function(field){
          return {field_id: field.id};
        })
      });
    });



    $scope.saveContentItem = function() {
      $scope.data.contentItem.$save().then(
        function() {
          flash.success = 'Saved content item information';
        },
        function(reason){
          flash.error = 'Error while saving content item information: ' + reason.data.error;
        }
      )
    };


    riot.mount('contenttype', {
      library: "RiotJS",
      someText: "With some text added in the angular controller"
    });
  });
