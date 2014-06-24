//= require spec_helper

(function() {
  'use strict';

  describe('Cortex Module', function() {

    beforeEach(function() {
      angular.mock.module('cortex');
    });

    describe('CortexCtrl', function() {
      var controller, $rootScope, $state, $stateParams, moment, currentUser;

      beforeEach(inject(function(_$rootScope_, _$state_, $controller, _$stateParams_, $http,
                                $window, _currentUser_, _moment_) {
        $rootScope   = _$rootScope_;
        $state       = _$state_;
        $stateParams = _$stateParams_;
        moment       = _moment_;
        currentUser  = _currentUser_;

        controller = $controller('CortexCtrl', {
          $rootScope:   $rootScope,
          $scope:       $rootScope.$new(),
          $state:       $state,
          $stateParams: $stateParams,
          $http:        $http,
          $window:      $window,
          currentUser:  currentUser,
          moment:       moment
        });
      }));

      it('should construct', function() {
        expect(controller).toBeTruthy();
      });

      it('should add necessary properties to $rootScope', function() {
        expect($rootScope.$state).toEqual($state);
        expect($rootScope.$stateParams).toEqual($stateParams);
        expect($rootScope.currentUser).toEqual(currentUser);
        expect($rootScope.moment).toEqual(moment);
      });
    });
  });
})();
