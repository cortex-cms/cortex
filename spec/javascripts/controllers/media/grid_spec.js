//= require spec_helper

(function() {
  'use strict';

  describe('Media Grid Module', function() {

    beforeEach(function() {
      angular.mock.module('cortex.controllers.media.grid');
    });

    describe('MediaGridCtrl', function($rootScope) {
      var createController, $scope;

      beforeEach(inject(function($controller, $rootScope, $state, $stateParams, _$httpBackend_,
                                 cortex, settings, mediaSelectType, flash, PostBodyEditorService,
                                 PostsPopupService) {
        $scope = $rootScope.$new();

        createController = function() {
          return $controller('MediaGridCtrl', {
            $scope                : $scope,
            $state                : $state,
            $stateParams          : $stateParams,
            cortex                : cortex,
            settings              : settings,
            mediaSelectType       : mediaSelectType,
            flash                 : flash,
            PostBodyEditorService : PostBodyEditorService,
            PostsPopupService     : PostsPopupService
          });
        };
      }));

      it('should construct', function() {
        expect(createController()).toBeTruthy();
      });

      it('should provide page');

      it('should provide data.media');

      it('should provide deleteMedia()');

      it('should update media when page changes');
    });
  });
})();
