var module = angular.module('cortex.controllers.posts.grid', [
    'ngTable',
    'ui.bootstrap',
    'cortex.services.cortex'
]);

module.controller('PostsGridCtrl', function($scope, cortex){
    $scope.data = {
        totalServerItems: 0,
        posts: cortex.posts.query()
    };
});
