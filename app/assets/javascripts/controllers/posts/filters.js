angular.module('cortex.controllers.posts.filters', [
])

.controller('PostsFiltersCtrl', function($scope){

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
