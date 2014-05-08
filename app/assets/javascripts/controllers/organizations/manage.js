angular.module('cortex.controllers.organizations.manage', [
    'ui.router.state',
    'angular-flash.service',
    'angular-flash.flash-alert-directive',
    'cortex.services.cortex',
    'cortex.settings'
])

.controller('OrganizationsManageCtrl', function($scope, $stateParams, $state, flash, events, cortex, TenantsTreeStatus) {
    // Open tenant hierarchy and details panels if an organization is selected
    if ($stateParams.organizationId && !$state.includes('cortex.organizations.manage.tenants')) {
        $state.go('.tenants');
    }

    $scope.tenantsTreeStatus = TenantsTreeStatus;

    $scope.deleteTenant = function(tenant){
            if (confirm('Are you sure you want to delete "' + tenant.name + '"?')) {
                cortex.tenants.delete({id: tenant.id}, function(data) {
                    var message;

                    if (tenant.parent_id) {
                        $scope.$broadcast(events.TENANT_HIERARCHY_CHANGE);
                        message = '"' + tenant.name + '" tenant was deleted successfully';
                    }
                    else {
                        $scope.$emit(events.ORGANIZATIONS_CHANGE);
                        message = '"' + tenant.name + '" organization was deleted successfully';

                        // Go to org manage if an org tenant was deleted
                        $state.go('cortex.organizations.manage');
                    }
                    flash.warn = message;
                });
            }
    };
});
