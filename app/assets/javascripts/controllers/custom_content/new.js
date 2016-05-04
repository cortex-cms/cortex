angular.module('cortex.controllers.custom_content.new', [])

  .controller('CustomContentNewCtrl', function($scope, $state) {
    riot.mount('contenttype', { library: "RiotJS" });
  });