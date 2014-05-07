var module = angular.module('cortex.controllers.tenants.edit', [
    'ui.router.state',
    'ui.bootstrap.datepicker',
    'angular-flash.service',
    'cortex.directives.tenantSettings',
    'cortex.settings'
]);

module.controller('EditTenantsCtrl', function($scope, $stateParams, $state, $timeout, events, cortex, hierarchyUtils, flash) {

    // angular-bootstrap datepicker settings
    $scope.datepicker = {
        format: 'yyyy/MM/dd',
        activateAtOpen: false,
        deactivateAtOpen: false,
        open: function(datepicker) {
            $timeout(function(){
                $scope.datepicker[datepicker] = true;
            });
        }
    };

    $scope.levelName = $stateParams.organizationId ? 'tenant' : 'organization';
    $scope.creatingOrganization = $stateParams.organizationId === '';

    // Fetch the tenant or create a new resource
    if ($stateParams.tenantId) {
        $scope.data.tenant = cortex.tenants.get({id: $stateParams.tenantId});
    }
    else {
        $scope.data.tenant = new cortex.tenants();
    }

    $scope.data.tenant.inherit_from_parent = true;

    // Initialize scope.data properties for organization tree and other directives
    $scope.data.tenants =
    {
        hierarchy: [],
        flattened: [],
        selected: null
    };

    // Fetch organization hierarchy
    if ($stateParams.organizationId) {
        cortex.tenants.get({id: $stateParams.organizationId, include_children: true}, function(tenant) {
            $scope.data.tenants.hierarchy = [tenant];
        });
    }
    $scope.creatingTenant = $stateParams.tenantId === '';

    $scope.selectParent = function(tenant){
        $scope.data.tenants.selected = tenant;
        $scope.data.tenant.parent_id = tenant.id;
    };

    $scope.save = function() {
        var tenantIsNew = !$scope.data.tenant.id;
        var tenantIsOrg = !$scope.data.tenant.parent_id;

        $scope.data.tenant.$save(function(tenant) {

            var message;
            if ($scope.creatingOrganization) {
                $scope.$emit(events.ORGANIZATIONS_CHANGE);

                if (tenantIsNew) {
                    message = 'Created new organization "' + tenant.name + '"';
                    $state.go('.', {tenantId: tenant.id});
                }
                else {
                    message = 'Saved organization "' + tenant.name + '"';
                }
            }
            else {
                if (tenantIsNew) {
                    message = 'Created new tenant "' + tenant.name + '" under "' + $scope.data.tenants.selected.name + '"' ;
                    $state.go('.', {tenantId: tenant.id, organizationId: $stateParams.organizationId});
                }
                else {
                    if (tenantIsOrg) {
                        message = 'Saved organization "' +  tenant.name + '"';
                        $scope.$emit(events.ORGANIZATIONS_CHANGE);
                    }
                    else {
                        message = 'Saved tenant "' +  tenant.name + '"';
                    }
                }
            }

            flash.success = message;
        });
    };
});
