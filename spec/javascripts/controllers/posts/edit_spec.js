//= require spec_helper

(function() {
  'use strict';

  describe('Post Editor Module', function() {
    beforeEach(function() {
      debaser()
          .module('cortex.controllers.posts.edit')
          .object('AddMediaService').withFunc('initRedactorMediaPlugin').returns({ })
          .object('currentUserAuthor', { full_name: "Test User"})
          .object('filters', { job_phases: [], industries: [] })
          .object('post', { })
          .object('ImageFitService').withFunc('initRedactorImageFitPlugin').returns({ })
          .object('flash').withFunc('success').returns({ })
          .object('categoriesHierarchy', {})
          .module('cortex.services.cortex')
          .debase()
    });

    describe('PostsEditCtrl', function($rootScope) {
      var $scope, $window, $state, $stateParams, $q, $httpBackend, flash, cortex, post, filters, categoriesHierarchy, constructController;
      beforeEach(inject(function($controller,  _$window_, _$state_, _$stateParams_, _$q_, _$httpBackend_, _cortex_) {
        $window = _$window_;
        $state = _$state_;
        $stateParams = _$stateParams_;
        $q           = _$q_;
        $httpBackend = _$httpBackend_;
        cortex = _cortex_;

        constructController = function() {
          return $controller('PostsEditCtrl', {
            $state: $state,
            $stateParams: $stateParams,
            $q: $q,
            $httpBackend: $httpBackend,
          });
        };
      }));

      it('should construct', function() {
        var controller = constructController();
        expect(controller).toBeTruthy();
      });

      it('should provide data.industries on scope', function() {
        var controller = constructController();
        expect(controller.data.industries).toBeDefined;
      });

      it('should provide data.post on scope', function() {
        var controller = constructController();
        expect(controller.data.post).toBeDefined;
      });

      it('should provide data.categoriesHierarchy on scope', function() {
        var controller = constructController();
        expect(controller.data.categoriesHierarchy).toBeDefined;
      });

      it('should set data.authorIsUser to true if creating a new post', function() {
        post = {};
        var controller = constructController();
        expect(controller.data.authorIsUser).toBeTruthy();
      });

      it('should set data.authorIsUser to true if editing a post that has an author', function() {
        var controller = constructController();
        controller.data.post.author = "Demosthenes";
        controller.data.post.id = 1;
        expect(controller.isAuthorUser(controller.data.post)).toBeTruthy();
      });

      it('should not set data.authorIsUser if editing a post that has a custom author', function() {
        var controller = constructController();
        controller.data.post.custom_author = "Locke";
        controller.data.post.id = 1;
        expect(controller.isAuthorUser(controller.data.post)).toBeFalsy();
      });
    });
  });
})();
