//= require spec_helper

(function() {
  'use strict';

  describe('Media Grid Module', function() {

    beforeEach(function() {
      angular.mock.module('cortex.controllers.media.grid');
    });

    describe('MediaGridCtrl', function($rootScope) {
      var createController, $scope, $stateParams, $state, $window, settings, media, cortex;

      beforeEach(inject(function($controller, $rootScope, _$state_, _$httpBackend_, _cortex_,
                                 _settings_, mediaSelectType, flash, PostBodyEditorService,
                                 PostsPopupService, _$window_) {
        $scope       = $rootScope.$new();
        $stateParams = {};
        $state       = _$state_;
        $window      = _$window_;
        settings     = _settings_;
        cortex       = _cortex_;
        media        = [{id: 1}, {id: 2}];

        // Mocked media response
        cortex.media.searchPaged = function(args, successFn) {
          var paging = {per_page: 10, page: 1};
          if (args) {
            paging = angular.extend(paging, args);
          }

          if (successFn) {
            successFn(media, {}, paging);
          }

          return media;
        };

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

      describe('$scope.page', function() {

        it('should provide query', function() {
          $stateParams.query = 'query';
          createController();
          expect($scope.page.query).toEqual($stateParams.query);
        });

        it('should use $stateParams.page if available', function() {
          $stateParams.page = 2;
          createController();
          expect($scope.page.page).toEqual($stateParams.page);
        });

        it('should provide default page', function() {
          createController();
          expect($scope.page.page).toEqual(1);
        });

        it('should use $stateParams.page if available', function() {
          $stateParams.page = 2;
          createController();
          expect($scope.page.page).toEqual($stateParams.page);
        });

        it('should provide default perPage', function() {
          createController();
          expect($scope.page.perPage).toEqual(settings.paging.defaultPerPage);
        });

        it('should use $stateParams.perPage if available', function() {
          $stateParams.perPage = 23;
          createController();
          expect($scope.page.perPage).toEqual($stateParams.perPage);
        });

        it('should provide next()', function() {
          $stateParams.page = 1;
          createController();
          $state.go = angular.noop;
          $scope.page.next();
          expect($scope.page.page).toEqual(2);
        });

        it('should provide previous()', function() {
          $stateParams.page = 2;
          createController();
          $state.go = angular.noop;
          $scope.page.previous();
          expect($scope.page.page).toEqual(1);
        });
      });

      it('should provide data.media', function() {
        createController();
        expect($scope.data.media.length).toEqual(2);
      });

      it('should provide deleteMedia()', function() {
        $window.confirm = function() { return true; };
        cortex.media.delete = function(args, successFn) {
          successFn();
        };
        createController();
        $scope.deleteMedia(media[0]);
        expect($scope.data.media).toNotContain(media[0]);
      });
    });
  });
})();
