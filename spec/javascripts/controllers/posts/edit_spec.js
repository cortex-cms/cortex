//= require spec_helper

(function() {
  'use strict';

  describe('Post Editor Module', function() {
    beforeEach(function() {
      angular.mock.module('cortex.controllers.posts.edit');
    });

    describe('PostsEditCtrl', function($rootScope) {
      var $scope, $state, $stateParams, $q, $httpBackend, flash, cortex, post, filters, categoriesHierarchy, currentUser, AddMediaService, createController;
      beforeEach(inject(function($controller, _$rootScope_, _$state_, _$stateParams_, _$q_, _$httpBackend_, _flash_, _cortex_, _post_, _filters_, _categoriesHierarchy_, _currentUser_, _AddMediaService_) {
        $rootScope = _$rootScope_;
        $scope = $rootScope.$new();
        $state = _$state_;
        $stateParams = _$stateParams_;
        $q           = _$q_;
        $httpBackend = _$httpBackend_;
        flash        = _flash_;
        cortex = _cortex_;
        post = _post_;
        filters = _filters_;
        categoriesHierarchy = _categoriesHierarchy_;
        currentUser = _currentUser_;
        AddMediaService = _AddMediaService_;

        createController = function() {
          return $controller('PostsEditCtrl', {
            $scope: $scope,
            $state: $state,
            $stateParams: $stateParams,
            $q: $q,
            $httpBackend: $httpBackend,
            flash: flash,
            cortex: cortex,
            post: post,
            filters: filters,
            categoriesHierarchy: categoriesHierarchy,
            currentUser: currentUser,
            AddMediaService: AddMediaService
          });
        }
      }));

      it('should construct', function() {
        expect(createController()).toBeTruthy();
      });

    });
  });
});