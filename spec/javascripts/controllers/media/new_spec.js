//= require spec_helper

(function() {
  'use strict';

  describe('Media New Module', function() {

    beforeEach(function() {
      angular.mock.module('cortex.states');
      angular.mock.module('cortex.controllers.media.new');
    });

    describe('MediaGridCtrl', function($rootScope) {
      var createController, $scope, $state, $q, $upload, $httpBackend, flash;

      beforeEach(inject(function($controller, _$rootScope_, $timeout, _$upload_, _$state_, _flash_, 
                                 cortex, settings, _$q_, _$httpBackend_) {
        $rootScope   = _$rootScope_;
        $scope       = $rootScope.$new();
        $state       = _$state_;
        $q           = _$q_;
        $upload      = _$upload_;
        $httpBackend = _$httpBackend_;
        flash        = _flash_;

        createController = function() {
          return $controller('MediaNewCtrl', {
            $scope   : $scope,
            $timeout : $timeout,
            $upload  : $upload,
            $state   : $state,
            $q       : $q,
            flash    : flash,
            cortex   : cortex,
            settings : settings
          });
        };
      }));

      it('should construct', function() {
        expect(createController()).toBeTruthy();
      });

      it('should provide data.media', function() {
        createController();
        expect($scope.data.media).toBeDefined();
      })

      it('should save youtube', function() {
        createController();
        var saved = false;

        $state.go = function(stateName) {
          $state.current.name = stateName;
        };

        $scope.data.media.$save = function() {
          saved = true;
          var defer = $q.defer();
          defer.resolve();
          return defer.promise;
        };

        angular.extend($scope.data.media, {video_id: '1234', name: 'Youtube video'});
        $scope.selectTab('youtube');
        $scope.saveMedia();

        $rootScope.$apply();

        expect($state.current.name).toBe('^.manage.components');
        expect(flash.success).toBe('Youtube video created');
        expect(saved).toBe(true);
      });

      it('should upload files', function() {
        createController();

        $state.go = function(stateName) {
          $state.current.name = stateName;
        };

        $httpBackend.expectPOST('/media').respond($scope.data.media);

        $scope.selectTab('file');
        $scope.data.media.$file = {name: 'file'};
        angular.extend($scope.data.media, {name: 'File', attachment: true});
        $scope.saveMedia();

        $rootScope.$apply();
        $httpBackend.flush();

        expect($state.current.name).toBe('^.manage.components');
        expect(flash.success).toBe('File created');
        $httpBackend.verifyNoOutstandingExpectation();
        $httpBackend.verifyNoOutstandingRequest();
      });

      it('should allow the tab to be selected', function() {
        createController();
        $scope.selectTab('file');
        expect($scope.currentTab).toBe('file');
      });

      it('should provide cancel()', function() {
        createController();

        $state.go = function(stateName) {
          $state.current.name = stateName;
        };

        $scope.cancel();
        expect($state.current.name).toBe('^.manage.components');
      });
    });
  });
})();
