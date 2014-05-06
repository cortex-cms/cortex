var module = angular.module('cortex.controllers.organizations', [
    'ui.router.state',
    'cortex.settings'
]);

module.controller('OrganizationsCtrl', function ($scope, $stateParams, $state, events, organizations) {

    $scope.data = {
        organizations: organizations
    };

    var orgId = $stateParams.organizationId;
    if (orgId) {
        $scope.data.organization = _.find(organizations, function(o){
            return o.id == orgId;
        });
    }

    $scope.$on(events.ORGANIZATIONS_CHANGE, function (event) {
        loadOrganizations();
    });
});
