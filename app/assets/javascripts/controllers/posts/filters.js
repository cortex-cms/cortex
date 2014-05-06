var module = angular.module('cortex.controllers.posts.filters', [
]);

module.controller('PostsFiltersCtrl', function($scope){

    $scope.data = {
        postTypes: [
            {name: 'Article'},
            {name: 'Graphic'},
            {name: 'Promo'},
            {name: 'Video'}
        ],
        filters: {
            date: {
                property: 'create_date'
            }
        }
    };
});
