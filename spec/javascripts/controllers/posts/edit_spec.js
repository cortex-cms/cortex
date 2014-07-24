//= require spec_helper

(function() {
  'use strict';

  describe('Post Editor Module', function() {
    beforeEach(function() {
      angular.mock.module('cortex.services.cortex');
      angular.mock.module('cortex.controllers.posts.edit');
    });

    describe('PostsEditCtrl', function($rootScope) {
      var $scope, $window, $state, $stateParams, $q, $httpBackend, flash, cortex, post, filters, categoriesHierarchy, currentUserAuthor, AddMediaService, constructController;
      beforeEach(inject(function($controller, _$rootScope_, _$window_, _$state_, _$stateParams_, _$q_, _$httpBackend_, _flash_, _cortex_, _AddMediaService_) {
        $rootScope = _$rootScope_;
        $window = _$window_;
        $scope = $rootScope.$new();
        $state = _$state_;
        $stateParams = _$stateParams_;
        $q           = _$q_;
        $httpBackend = _$httpBackend_;
        post         = {};
        flash        = _flash_;
        cortex = _cortex_;
        filters = cortex.posts.filters();
        categoriesHierarchy = cortex.categories.hierarchy();
        currentUserAuthor = { full_name: "Test User" };
        AddMediaService = _AddMediaService_;

        constructController = function() {
          return $controller('PostsEditCtrl', {
            $scope: $scope,
            $state: $state,
            $stateParams: $stateParams,
            $q: $q,
            $httpBackend: $httpBackend,
            flash: flash,
            post: post,
            filters: filters,
            categoriesHierarchy: categoriesHierarchy,
            currentUserAuthor: currentUserAuthor,
            AddMediaService: AddMediaService
          });
        };
      }));

      it('should construct', function() {
        var controller = constructController();
        expect(controller).toBeTruthy();
      });

      it('should provide data.industries on scope', function() {
        var controller = constructController();
        expect($scope.data.industries).toEqual(filters.industries);
      });

      it('should provide data.post on scope', function() {
        var controller = constructController();
        expect($scope.data.post).toEqual(post);
      });

      it('should provide data.categoriesHierarchy on scope', function() {
        var controller = constructController();
        expect($scope.data.categoriesHierarchy).toEqual(categoriesHierarchy);
      });

      it('should set data.authorIsUser to true if creating a new post', function() {
        post = {};
        var controller = constructController();
        expect($scope.data.authorIsUser).toBeTruthy();
      });

      it('should set data.authorIsUser to true if editing a post that has an author', function() {
        post = {
          id: 1,
          author: {id: 1, firstname: 'Plinkett'}
        };
        var controller = constructController();
        expect($scope.data.authorIsUser).toBeTruthy();
      });

      it('should not set data.authorIsUser if editing a post that has a custom author', function() {
        post = {
          id: 1,
          custom_author: 'Locke'
        };
        var controller = constructController();
        expect($scope.data.authorIsUser).toBeFalsy();
      });

      it('should provide the Media Redactor plugin on window', function() {
        var controller = constructController();
        expect($window.RedactorPlugins.media).toBeTruthy();
      });
    });
  });
})();
